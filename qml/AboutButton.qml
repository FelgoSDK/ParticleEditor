import VPlay 1.0
import QtQuick 1.1

Item {
  id: aboutButton
  width: buttonImage.width
  height: buttonImage.height

  signal clicked()

  property string sourceNormal: "left_normal.png"
  property string sourceHover: "left_hover.png"
  property string sourceClick: "left_click.png"

  SingleSpriteFromFile {
    id: buttonImage
    translateToCenterAnchor: false
    filename: "img/aboutscreen-sd.json"
    source: sourceNormal
  }
  SingleSpriteFromFile {
    id: buttonImageHover
    translateToCenterAnchor: false
    filename: "img/aboutscreen-sd.json"
    source: sourceHover
    visible: false
  }
  SingleSpriteFromFile {
    id: buttonImagePressed
    translateToCenterAnchor: false
    filename: "img/aboutscreen-sd.json"
    source: sourceClick
    visible: false
  }

  MouseArea {
    anchors.fill: parent
    enabled: !isCurrentlyMoving


    // hovering works only in qml atm
    hoverEnabled: true
    onEntered: {
      buttonImageHover.visible = true
      buttonImage.visible = false
      buttonImagePressed.visible = false
    }
    onExited:  {
      buttonImageHover.visible = false
      buttonImage.visible = true
      buttonImagePressed.visible = false
    }

    onPressed: {
      buttonImageHover.visible = false
      buttonImage.visible = false
      buttonImagePressed.visible = true
    }

    onReleased: {
      buttonImageHover.visible = false
      buttonImage.visible = true
      buttonImagePressed.visible = false
    }

    onCanceled: {
      buttonImageHover.visible = false
      buttonImage.visible = true
      buttonImagePressed.visible = false
    }


    onClicked: {
      aboutButton.clicked()
    }
  }

}
