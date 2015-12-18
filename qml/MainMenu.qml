import VPlay 2.0
import QtQuick 2.2
import QtQuick.Controls 1.1

Item {
  id: menuEditorWrapper
  property alias menuEditor: menuEditor

  width: scene.gameWindowAnchorItem.width/2.5
  height : scene.gameWindowAnchorItem.height

  property variant mainMenuContentParticles

  ItemEditor {
    id: menuEditor

    width: parent.width
    height: parent.height

    currentEditableType: "Menu"
    defaultGroupName: "Main Menu"

    Component.onCompleted: {
      menuEditor.addItemsToExternalGroupPanel(menuEditor.defaultGroupName,Qt.resolvedUrl("MainMenuContent.qml"))
      mainMenuContentParticles = menuEditor.addItemsToExternalGroupPanel("Particles",Qt.resolvedUrl("MainMenuContentParticles.qml"))
      mainMenuContentParticles.fillListWithFiles()
    }
  }
  // Move out of the screen
  x: __outslidedX
  y: scene.gameWindowAnchorItem.y
  // Save the x position when the editor is slided out completely
  property int __outslidedX:  scene.gameWindowAnchorItem.x-menuEditor.width

  // Add an additional offset to move the editor inside/outside of the visible screen.
  property int offsetX: __outslidedX+menuEditor.width

  // The duration of the slide animation for this editor
  property int slideDuration: 800

  // status at the beginning is outside
  property bool sliderOut: true
  Behavior on x {
    SmoothedAnimation { duration: menuEditorWrapper.slideDuration; easing.type: Easing.InOutQuad }
  }

  onXChanged: {
    if(x <= __outslidedX) {
      menuEditor.visible = false
    } else {
      menuEditor.visible = true
    }
  }



  // add a button to slide the editor in and out
  MultiResolutionImage {
    id: pullUp
    width: 54
    height: 20
    // rotate button
    transformOrigin: Item.Center
    rotation: -90
    // move button to correct position
    x: menuEditor.width+height/2-width/2
    anchors.verticalCenter: parent.verticalCenter
    source: "../assets/img/button-pullup.png"

    MouseArea { // MultiTouchArea
      width: parent.width+30
      height: parent.height+20
      x: -(width-parent.width)/2

      // It changes the x position of the menuEditor
      /*multiTouch.target: menuEditorWrapper
      // The editor should move only into X direction therefore block X direction
      multiTouch.dragAxis: MultiTouch.XAxis
      // limit the minimum and maximum of the touch area, because the
      // paddle should not move into the wall
      multiTouch.minimumX: menuEditorWrapper.__outslidedX
      multiTouch.maximumX: menuEditorWrapper.__outslidedX+menuEditor.width*/
      onReleased: {
        menuEditorWrapper.slide()
      }
    }
  }

  function slide(pos) {
    // close the about panel
    aboutPanel.closePanel()

    if(menuEditorWrapper.sliderOut) {
      // move out only if editor is out more than a half or completely hidden
      if(menuEditorWrapper.x > __outslidedX+menuEditor.width/2 || menuEditorWrapper.x <= __outslidedX) {
        x = offsetX
        menuEditorWrapper.sliderOut = false
      } else {
        x = __outslidedX
        menuEditorWrapper.sliderOut = true
      }

    } else {
      // move in only if editor is in more than a half or completely out
      if(menuEditorWrapper.x < __outslidedX+menuEditor.width/2 || menuEditorWrapper.x >= offsetX) {
        x = __outslidedX
        menuEditorWrapper.sliderOut = true
      } else {
        x = offsetX
        menuEditorWrapper.sliderOut = false
      }
    }
  }
}

