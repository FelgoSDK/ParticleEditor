import QtQuick 1.1
import VPlay 1.0

Scene {
  id: scene
  // this is important, as it serves as the reference size for the mass of the phyiscs objects, because the mass of a body depends on the width of its images
  // use 480x320 (for landscape games) or 320x480 (for portrait games), as it then works on smaller devices as well
  // if you only want to target tablets, this size might be increased to e.g. 1024x768 when targeting iPad-only
  // when the screen size is bigger than the logical scene size defined here (e.g. 800x480), the content will be scaled automatically with the default scalemode "letterbox"
  // the scene can be placed in the bigger window with the properties sceneAlignmentX & sceneAlignmentY (both default to center)
  // so to use the remaining screen size and not show black borders around the edges, use a bigger background image
  // the recommended maximum background size is 576x368 for sd-images, and 1152x736 for hd-images and 2304x1472 for hd2-images
  // these factors are calculated by starting with a 3:2 aspect ratio (480x320) and considering the worst aspect ratios 16:9 and 4:3
  width: 480
  height: 320
  focus: true

  property alias mainMenu: mainMenu.menuEditor
  property alias entityMenu: itemEditor
  property alias itemEditor: itemEditor.itemEditor
  property alias loadMessage: loadMessage
  property alias innerSpace: scene.innerSpaceWidth
  property alias aboutPanel: aboutPanel

  property int innerSpaceWidth: mainMenu.menuEditor.width-4*5

  property color backgroundColor: Qt.rgba(0,0,0,1.0)
  property bool entityBaseVisible: false

  onEntityBaseVisibleChanged: {
    // get all particles and set the status
    var entities = entityManager.getEntityArrayByType("particleEntity")
    for(var i=0; i<entities.length; ++i) {
      entities[i].entityBaseVisible = scene.entityBaseVisible
    }
  }

  property variant selectedEntity: null
  // everything is aligned the gameWindowAnchor use the correct alignment with different displays
  property int usageAreaWidth: scene.gameWindowAnchorItem.x+scene.gameWindowAnchorItem.width
  property int usageAreaHeight: scene.gameWindowAnchorItem.y+scene.gameWindowAnchorItem.height
  // used for picking a particle
  property int pickableAreaSize: 50

  Rectangle {
    id: background
    x: scene.gameWindowAnchorItem.x
    y: scene.gameWindowAnchorItem.y
    width: scene.gameWindowAnchorItem.width
    height: scene.gameWindowAnchorItem.height
    color: scene.backgroundColor
  }

  EditableComponent {
    id: mainMenuComponent
    targetEditor: mainMenu.menuEditor
    editableType: "Menu"
    defaultGroup: editableType
    properties: {
      "Background": {
        "entityBaseVisible": {"label": "Entity Base Visible"},
        "backgroundColor": {"min": 0, "max": 255,"stepsize": 1, "label": "Background Color"}
      }
    }
  }

  MouseArea {
    id: mouseArea
    objectName: "MouseArea"
    width: usageAreaWidth
    height: usageAreaHeight

    onPressed: {
      // Check if an entity is below touch point
      var entities = entityManager.getEntityArrayByType("particleEntity")
      for(var i=0; i<entities.length; ++i) {
        if(entities[i].x > mouse.x-pickableAreaSize && entities[i].x < mouse.x+pickableAreaSize && entities[i].y > mouse.y-pickableAreaSize && entities[i].y < mouse.y+pickableAreaSize) {
          selectedEntity = entities[i]
          scene.itemEditor.currentEditableType = utils.cropPath(entities[i].particleType, true)
          break
        }
      }
    }
    onMousePositionChanged: {
      // move the selected entity (if selected) only if it's in the presentation area!
      if(selectedEntity && mouse.x < usageAreaWidth && mouse.x > 0) {
        selectedEntity.x = mouse.x
      }
      if(selectedEntity && mouse.y < usageAreaHeight && mouse.y > 0) {
        selectedEntity.y = mouse.y
      }
    }
    onReleased: {
      // release the selected entity
      selectedEntity = 0
    }
    onClicked: {
      var entities = entityManager.getEntityArrayByType("particleEntity")
      for(var i=0; i<entities.length; ++i) {
        if(entities[i].x > mouse.x-pickableAreaSize && entities[i].x < mouse.x+pickableAreaSize && entities[i].y > mouse.y-pickableAreaSize && entities[i].y < mouse.y+pickableAreaSize) {
          entities[i].printParticle()
          break
        }
      }

    }
  }

  AboutPanel {
    id: aboutPanel
    x: gameWindowAnchorItem.x
    y: gameWindowAnchorItem.y
  }

  onWidthChanged: {
    mainMenu.slide()
    itemEditor.slide()
  }
  onHeightChanged: {
    mainMenu.slide()
    itemEditor.slide()
  }

  // Left main menu
  MainMenu {
    id: mainMenu
    // always on top of all particles
    z:1000
  }

  // Right entity property menu
  EntityPropertiesMenu {
    id: itemEditor
    // always on top of all particles
    z:1000
  }

  // handle this signal in each Scene
  signal backPressed

  Connections {
    // nativeUtils should only be connected, when this is the active scene
      target: nativeUtils
      onMessageBoxFinished: {
        console.debug("the user confirmed the Ok/Cancel dialog with:", accepted)
        if(accepted)
          Qt.quit()
      }
  }

  onBackPressed: {
    nativeUtils.displayMessageBox(qsTr("Really quit the application?"), "", 2);
  }

  Keys.onPressed: {
    // only simulate on desktop platforms!
    if(event.key === Qt.Key_Backspace && system.desktopPlatform) {
      backPressed()
    }

    if(event.key === Qt.Key_D && system.desktopPlatform) {
      mainMenu.menuEditor.contentDelegateObj.headerNext()
    } else if(event.key === Qt.Key_A && system.desktopPlatform) {
      mainMenu.menuEditor.contentDelegateObj.headerPrev()
    }
    if(event.key === Qt.Key_Right && system.desktopPlatform) {
      itemEditor.itemEditor.contentDelegateObj.headerNext()
    } else if(event.key === Qt.Key_Left && system.desktopPlatform) {
      itemEditor.itemEditor.contentDelegateObj.headerPrev()
    }
  }

  Keys.onBackPressed: {
    // Android
    backPressed()
  }

  Rectangle {
    id: loadMessage
    z:1001
    x: scene.gameWindowAnchorItem.x
    y: scene.gameWindowAnchorItem.y
    width: scene.gameWindowAnchorItem.width
    height: scene.gameWindowAnchorItem.height
    color: "black"
    opacity: 0.5
    visible: itemEditor.state === "loading" || mainMenu.state === "loading"

    Text {
      anchors.centerIn: parent
      text: "loading..."
      color: "white"
    }
  }

}

