import VPlay 1.0
import QtQuick 1.1

Item {
  id: itemEditorWrapper
  property alias itemEditor: itemEditor
  property alias state: itemEditor.state

  width: scene.gameWindowAnchorItem.width/2.5
  height : scene.gameWindowAnchorItem.height


  ItemEditor {
    id: itemEditor

    width: parent.width
    height: parent.height

    currentEditableType: "FireParticle"
    property bool dataStorageLocation: false
  }

  // Move out of the screen
  x: __outslidedX
  y: scene.gameWindowAnchorItem.y
  // Save the x position when the editor is slided out completely
  property int __outslidedX:  scene.gameWindowAnchorItem.x+scene.gameWindowAnchorItem.width

  // Add an additional offset to move the editor inside/outside of the visible screen.
  property int offsetX: __outslidedX-itemEditor.width

  // The duration of the slide animation for this editor
  property int slideDuration: 800

  // status at the beginning is outside
  property bool sliderOut: true
  Behavior on x {
    SmoothedAnimation { duration: itemEditorWrapper.slideDuration; easing.type: Easing.InOutQuad }
  }

  onXChanged: {
    if(x >= __outslidedX) {
      itemEditor.visible = false
    } else {
      itemEditor.visible = true
    }
  }

  // add a button to slide the editor in and out
  Button {
    id: pullUp
    objectName: "pullUp"
    width: 54
    height: 20
    // rotate button
    transformOrigin: Item.Center
    rotation: 90
    // move button to correct position
    x: -(height/2+width/2)
    anchors.verticalCenter: parent.verticalCenter

    iconName: "pullup"

    MultiTouchArea {
      width: parent.width+30
      height: parent.height+20
      x: -(width-parent.width)/2

      // It changes the x position of the itemEditor
      multiTouch.target: itemEditorWrapper
      // The editor should move only into X direction therefore block X direction
      multiTouch.dragAxis: MultiTouch.XAxis
      // limit the minimum and maximum of the touch area, because the
      // paddle should not move into the wall
      multiTouch.minimumX: itemEditorWrapper.__outslidedX-itemEditor.width
      multiTouch.maximumX: itemEditorWrapper.__outslidedX
      onReleased: {
        itemEditorWrapper.slide()
      }
    }
  }

  function slide(pos) {
    // close the about panel
    aboutPanel.closePanel()
    if(itemEditorWrapper.sliderOut) {
      // move out only if editor is out more than a half or completely hidden
      if(itemEditorWrapper.x < __outslidedX-itemEditor.width/2 || itemEditorWrapper.x >= __outslidedX) {
        x = offsetX
        itemEditorWrapper.sliderOut = false
      } else {
        x = __outslidedX
        itemEditorWrapper.sliderOut = true
      }

    } else {
      // move in only if editor is in more than a half or completely out
      if(itemEditorWrapper.x > __outslidedX-itemEditor.width/2 || itemEditorWrapper.x <= offsetX) {
        x = __outslidedX
        itemEditorWrapper.sliderOut = true
      } else {
        x = offsetX
        itemEditorWrapper.sliderOut = false
      }
    }
  }
}
