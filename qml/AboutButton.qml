import Felgo 3.0
import QtQuick 2.2

Item {
  id: aboutButton
  width: buttonImage.width
  height: buttonImage.height

  signal clicked()

  property string sourceNormal: "../assets/img/left_normal.png"
  property string sourceHover: "../assets/img/left_hover.png"
  property string sourceClick: "../assets/img/left_click.png"

  MultiResolutionImage {
    id: buttonImage
    source: sourceNormal
  }
  MultiResolutionImage {
    id: buttonImageHover
    source: sourceHover
    visible: false
  }
  MultiResolutionImage {
    id: buttonImagePressed
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
