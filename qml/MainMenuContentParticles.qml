import VPlay 1.0
import QtQuick 1.1
import "ArrayStorage.js" as ArrayStorage
import "ArrayStorage.js" as ArrayStorage2
Column {
  id: column

  width: innerSpace
  anchors.horizontalCenter: parent.horizontalCenter

  spacing: 6

  property variant particleFiles: []
  property variant particleFilesDataStorage: []

  // aliases to scene won't work here because during creation time (dynamically) the scene is not know
  // by this component.
  property variant editableType
  property bool dataStorageLocation: false

  onEditableTypeChanged: {
    scene.itemEditor.currentEditableType = editableType
  }
  onDataStorageLocationChanged: {
    scene.itemEditor.dataStorageLocation = dataStorageLocation
  }

  Column {
    id: customParticles

    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter

    spacing: 6

    Rectangle {
      visible: false
    }


    Item {
      width: parent.width
      height: customParticlesText.height
      Text {
        id: customParticlesText
        text: "Custom Particles"
        color: "white"
      }

      // Add a browse custom particles button on desktop platforms.
      Text {
        id: browseButton
        anchors.left: customParticlesText.right
        anchors.leftMargin: 10
        //width: parent.width
        text: "[...]"
        color: "white"
        visible: false
      }
      MouseArea {
        anchors.fill: parent
        onClicked: {
          nativeUtils.openUrl(fileUtils.getDataStorageUrl(system.getConfigValue("title")+"/particles/"))
        }
      }
    }

  }

  Rectangle {
    width: parent.width
    height: 2
    visible: false
  }
  Rectangle {
    width: parent.width
    height: 2
    color: "white"
    opacity: 0.75
  }
  Rectangle {
    width: parent.width
    height: 2
    visible: false
  }

  function fillListWithFiles() {
    var i = 0
    var j = 0
    // List all particles in the qml location
    var stringList = fileUtils.listFiles(Qt.resolvedUrl("particles/"),["*.json"])

    // Create file list with all images
    var files = []
    for(i = 0; i < stringList.length; i++){
      files[i] = stringList[i]
    }

    particleFiles = files

    // List all particles in the data storage location
    stringList = fileUtils.listFiles(fileUtils.getDataStorageUrl(system.getConfigValue("title")+"/particles/"), ["*.json"])
    files = []
    for(i = 0; i < stringList.length; i++){
      files[i] = stringList[i]
    }

    particleFilesDataStorage = files

    // Add buttons for each particle
    // custom
    var currentArray = ArrayStorage.getArray()
    var isAlreadyInArray = false
    for(i = 0; i<particleFilesDataStorage.length; ++i) {
      for(j = 0; j<currentArray.length; ++j) {
        if(currentArray[j].text === ut.cropPath(particleFilesDataStorage[i], true)) {
          isAlreadyInArray = true
        }
      }
      if(!isAlreadyInArray) {
        ArrayStorage.push(addButtonModel(particleFilesDataStorage[i], true))
      }
      isAlreadyInArray = false
    }

    // Add a browse custom particles button on desktop platforms.
    if(currentArray.length && (system.isPlatform(System.Mac) || system.isPlatform(System.Linux) || system.isPlatform(System.Windows))) {
      browseButton.visible = true
    }

    // pre-defined
    currentArray = ArrayStorage2.getArray()
    isAlreadyInArray = false
    for(i = 0; i<particleFiles.length; ++i) {
      for(j = 0; j<currentArray.length; ++j) {
        if(currentArray[j].text === ut.cropPath(particleFiles[i], true)) {
          isAlreadyInArray = true
        }
      }
      if(!isAlreadyInArray) {
        ArrayStorage2.push(addButtonModel(particleFiles[i], false))
      }
      isAlreadyInArray = false
    }
  }

  // we can not access utils from gamewindow here
  Utils {
    id: ut
  }

  /*!
    Add a button for particle creation with a name of the particle and if it is stored in the qml directory or in data storage.
    */
  function addButtonModel(particleName, isDataStorageLocation) {
    var component = Qt.createComponent("ParticleButton.qml");
    if (component.status === Component.Ready) {
      var buttonObject = component.createObject(isDataStorageLocation ? customParticles : column, {"text" : ut.cropPath(particleName, true),
                                                            "width": column.width,
                                                            //"height": column.buttonHeight,
                                                            "dataStorageLocation": isDataStorageLocation
                                                          });
      if (buttonObject === null) {
        console.debug("[ParticleButton] ERROR: creating repeater object failed!")
        return 0
      } else {
        loadItemWithCocos(buttonObject)
        return buttonObject
      }
    } else if(component.status === Component.Error) {
      console.log("[ParticleButton] ERROR: loading repeater object failed:", component.errorString())
      return 0
    }
  }
}
