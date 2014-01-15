import VPlay 1.0
import QtQuick 1.1

Column {
  id: column
  property int cnt: 1
  property int buttonHeight: 30
  property variant dialogCaller
  property string oldName: ""

  width: innerSpace
  anchors.horizontalCenter: parent.horizontalCenter

  spacing: 6

  Text {
    color: "white"
    text: "Creation Count "+column.cnt
  }
  Slider {
    width: column.width
    maximumValue: 30
    value: 1
    defaultValue: 1
    stepSize: 1
    valueIndicatorVisible: false
    Component.onCompleted: {
      addBinding(column,"cnt")
    }
  }
  Button {
    width: column.width
    height: column.buttonHeight
    text: "Add "+scene.itemEditor.currentEditableType
    onClicked: {
      createParticle()
    }
  }
  Button {
    id: filename
    width: column.width
    height: column.buttonHeight
    text: "Save as"
    onClicked: {
      column.oldName = scene.itemEditor.currentEditableType
      column.dialogCaller = filename
      nativeUtils.displayTextInput("Save as", "Enter Particle Name", scene.itemEditor.currentEditableType)
    }
  }
  Button {
    width: column.width
    height: column.buttonHeight
    text: "Respawn Particles"
    onClicked: {
      // Log the respawn function
      flurry.logEvent("Respawn")
      var entities = entityManager.getEntityArrayByType("particleEntity")
      for(var i=0; i<entities.length; ++i) {
        entities[i].respawnParticle()
      }
    }
  }
  Button {
    width: column.width
    height: column.buttonHeight
    text: "Remove All"
    onClicked: {
      // Log the remove all function
      flurry.logEvent("RemoveAll")
      var entities = entityManager.getEntityArrayByType("particleEntity")
      for(var i=0; i<entities.length; ++i) {
        entityManager.removeEntityById(entities[i].entityId)
      }
    }
  }
  Button {
    width: column.width
    height: column.buttonHeight
    text: "Remove First"
    onClicked: {
      // Log the remove first function
      flurry.logEvent("RemoveFirst")
      var entities = entityManager.getEntityArrayByType("particleEntity")
      if(entities.length > 0) {
        entityManager.removeEntityById(entities[0].entityId)
      }
    }
  }
  Button {
    width: column.width
    height: column.buttonHeight
    text: "Remove Last"
    onClicked: {
      // Log the remove first function
      flurry.logEvent("RemoveLast")
      var entities = entityManager.getEntityArrayByType("particleEntity")
      if(entities.length > 0) {
        entityManager.removeEntityById(entities[entities.length-1].entityId)
      }
    }
  }

  Button {
    width: column.width
    height: column.buttonHeight
    text: "Save to .plist"
    onClicked: {
      // Log the save to .plist function
      flurry.logEvent("SavePlist","name",scene.itemEditor.currentEditableType)
      var entities = entityManager.getEntityArrayByType("particleEntity")
      for(var i=0; i<entities.length; ++i) {
        if(scene.itemEditor.currentEditableType+".json" === entities[i].particleType) {
          entities[i].saveToPList()
        }
      }
    }
  }

  Button {
    id: mail
    width: column.width
    height: column.buttonHeight
    text: "Send Particle .json"
    onClicked: {
      column.dialogCaller = mail
      nativeUtils.displayTextInput("Send to", "Enter Email", "your@email.com")
    }
  }

  Button {
    id: mailPList
    width: column.width
    height: column.buttonHeight
    text: "Send Particle .plist"
    onClicked: {
      column.dialogCaller = mailPList
      nativeUtils.displayTextInput("Send to", "Enter Email", "your@email.com")
    }
  }

  Connections {
    target: nativeUtils
    onTextInputFinished: {
      if(accepted) {
        if(column.dialogCaller === filename) {
          // Log the name of the new particle
          flurry.logEvent("Save","Particle",filename)

          scene.itemEditor.saveItem(system.getConfigValue("title")+"/particles/",scene.itemEditor.currentEditableType,enteredText)
          // save particle will be loaded from data storage
          mainMenu.mainMenuContentParticles.dataStorageLocation = true

          // rename last particle
          var entities = entityManager.getEntityArrayByType("particleEntity")
          for(var i=0; i<entities.length; ++i) {
            if(column.oldName+".json" === entities[i].particleType) {
              entities[i].dataStorageLocation = true
              entities[i].particleType = scene.itemEditor.currentEditableType+".json"
            }
          }

          // update the particles list
          mainMenu.mainMenuContentParticles.fillListWithFiles()
        } else if(column.dialogCaller === mail) {
          // Log the save to .plist function
          flurry.logEvent("SendJSON","name",scene.itemEditor.currentEditableType)

          var entities = entityManager.getEntityArrayByType("particleEntity")
          for(var i=0; i<entities.length; ++i) {
            if(entities[i].particleType === scene.itemEditor.currentEditableType+".json") {
              entities[i].sendParticlePerMail(enteredText)
              return
            }
          }
        } else if(column.dialogCaller === mailPList) {
          // Log the save to .plist function
          flurry.logEvent("SendPList","name",scene.itemEditor.currentEditableType)

          var entities = entityManager.getEntityArrayByType("particleEntity")
          for(var i=0; i<entities.length; ++i) {
            if(entities[i].particleType === scene.itemEditor.currentEditableType+".json") {
              entities[i].sendParticlePListPerMail(enteredText)
              return
            }
          }
        }
      }
    }
  }

  function createParticle() {
    // Log which particle was added how often
    flurry.logEvent("Add",scene.itemEditor.currentEditableType,column.cnt)

    for(var i = 0; i < column.cnt; ++i) {
      var newEntityProperties = {
        x: Math.random()*scene.usageAreaWidth,
        y: Math.random()*scene.usageAreaHeight,
        particleType: scene.itemEditor.currentEditableType+".json",
        dataStorageLocation: scene.itemEditor.dataStorageLocation,
        entityBaseVisible: scene.entityBaseVisible
      }
      //console.debug("MainMenuContent: createParticle() called, newEntityProperties:", JSON.stringify(newEntityProperties))
      var entityID =  entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("particles/ParticleEntity.qml"), newEntityProperties)
    }
  }

  Component.onCompleted: {
    createParticle()
  }
}
