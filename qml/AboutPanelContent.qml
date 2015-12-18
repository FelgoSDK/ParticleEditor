import VPlay 2.0
import QtQuick 2.2

Item {
  id: contentPanel
  width: 440
  height: 230

  property int aboutPanelNumber
  property real slideWidth
  property int panelNumber
  property alias isCurrentlyMoving: contentPanel.isMoving
  property bool isMoving: false

  onMoveToLeft: isMoving = true
  onMoveToRight: isMoving = true

  onPanelNumberChanged: {
    about1.visible = false
    about2.visible = false
    about3.visible = false
    about4.visible = false
    if(panelNumber === 1) {
      about1.visible = true
    } else if(panelNumber === 2) {
      about2.visible = true
    } else if(panelNumber === 3) {
      about3.visible = true
    } else if(panelNumber === 4) {
      about4.visible = true
    }
  }

  signal finishedAnimation()
  onFinishedAnimation: {
    isMoving = false
  }

  signal moveToLeft()
  signal moveToRight()

  AboutButton {
    id: leftButton
    x: 10
    y: 16
    sourceNormal: "../assets/img/left_normal.png"
    sourceHover: "../assets/img/left_hover.png"
    sourceClick: "../assets/img/left_click.png"
    onClicked: {
      contentPanel.moveToLeft()
    }
  }

  AboutButton {
    id: rightButton
    x: 380
    y: 16
    sourceNormal: "../assets/img/right_normal.png"
    sourceHover: "../assets/img/right_hover.png"
    sourceClick: "../assets/img/right_click.png"
    onClicked: {
      contentPanel.moveToRight()
    }
  }

  Item {
    id: about1
    Item {
      width: contentPanel.width
      height: contentPanel.height

      AboutButton {
        x: 78
        y: 16
        sourceNormal: "../assets/img/title_normal.png"
        sourceHover: "../assets/img/title_hover.png"
        sourceClick: "../assets/img/title_click.png"
        onClicked: {
          // Log calls to v-play.net
          flurry.logEvent("V-Play.net - about v-play")
          nativeUtils.openUrl("http://www.v-play.net")
        }
        Text {
          anchors.centerIn: parent
          text: "About V-Play"
          color: "#b9ff0a"
        }
      }

      Text {
        y: 67
        anchors.horizontalCenter: parent.horizontalCenter
        text: "powering 2D games with"
        color: "white"
      }

      AboutButton {
        x: 157
        y: 94
        sourceNormal: "../assets/img/qt_normal.png"
        sourceHover: "../assets/img/qt_hover.png"
        sourceClick: "../assets/img/qt_click.png"
        onClicked: {
          // Log calls to qt benefits page
          flurry.logEvent("qt-benefits")
          nativeUtils.openUrl("http://v-play.net/benefits/#qtdeveloper")
        }
      }
      AboutButton {
        x: 222
        y: 90
        sourceNormal: "../assets/img/cocos_normal.png"
        sourceHover: "../assets/img/cocos_hover.png"
        sourceClick: "../assets/img/cocos_click.png"
        onClicked: {
          // Log calls to cocos benefits page
          flurry.logEvent("cocos-benefits")
          nativeUtils.openUrl("http://v-play.net/benefits/#cocosdeveloper")
        }
      }

      AboutButton {
        x: 124
        y: 192
        sourceNormal: "../assets/img/link_normal.png"
        sourceHover: "../assets/img/link_hover.png"
        sourceClick: "../assets/img/link_click.png"
        onClicked: {
          // Log calls to v-play.net
          flurry.logEvent("V-Play.net")
          nativeUtils.openUrl("http://www.v-play.net")
        }
        Text {
          anchors.centerIn: parent
          text: "www.v-play.net"
          color: "#b9ff0a"
        }
      }
    }
  }

  Item {
    id: about2
    visible: false
    Item {
      width: contentPanel.width
      height: contentPanel.height

      AboutButton {
        x: 78
        y: 16
        sourceNormal: "../assets/img/title_normal.png"
        sourceHover: "../assets/img/title_hover.png"
        sourceClick: "../assets/img/title_click.png"
        onClicked: {
          // Log calls to v-play.net
          flurry.logEvent("V-Play.net - v-play game engine features")
          nativeUtils.openUrl("http://www.v-play.net")
        }
        Text {
          anchors.centerIn: parent
          text: "V-Play Game Engine - Features"
          color: "#b9ff0a"
        }
      }

      Column {
        x: 45
        y: 70
        spacing: 7
        AboutButton {
          sourceNormal: "../assets/img/interactive_item_normal.png"
          sourceHover: "../assets/img/interactive_item_hover.png"
          sourceClick: "../assets/img/interactive_item_click.png"
          onClicked: {
            // Log calls to v-play.net
            flurry.logEvent("V-Play.net - v-play game engine features major platforms")
            nativeUtils.openUrl("http://v-play.net/features/")
          }
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Cross-Platform 2D Engine for all major platforms"
            color: "white"
            font.pixelSize: 12
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/interactive_item_normal.png"
          sourceHover: "../assets/img/interactive_item_hover.png"
          sourceClick: "../assets/img/interactive_item_click.png"
          onClicked: {
            // Log calls to v-play.net
            flurry.logEvent("V-Play.net - v-play game engine features single codebase")
            nativeUtils.openUrl("http://v-play.net/features/")
          }
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Single Codebase with Native Performance"
            color: "white"
            font.pixelSize: 12
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/interactive_item_normal.png"
          sourceHover: "../assets/img/interactive_item_hover.png"
          sourceClick: "../assets/img/interactive_item_click.png"
          onClicked: {
            // Log calls to v-play.net
            flurry.logEvent("V-Play.net - v-play game engine features levels")
            nativeUtils.openUrl("http://v-play.net/2013/05/v-play-level-editor/")
          }
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Give your players the power to create their own levels"
            color: "white"
            font.pixelSize: 12
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/interactive_item_normal.png"
          sourceHover: "../assets/img/interactive_item_hover.png"
          sourceClick: "../assets/img/interactive_item_click.png"
          onClicked: {
            // Log calls to v-play.net
            flurry.logEvent("V-Play.net - v-play game engine features introduction")
            nativeUtils.openUrl("http://v-play.net/doc/index.html#qml-introduction")
          }
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Less code with QML and JS"
            color: "white"
            font.pixelSize: 12
          }
        }

      }

    }
  }
  Item {
    id: about3
    visible: false
    Item {
      width: contentPanel.width
      height: contentPanel.height

      AboutButton {
        x: 78
        y: 16
        sourceNormal: "../assets/img/title_normal.png"
        sourceHover: "../assets/img/title_hover.png"
        sourceClick: "../assets/img/title_click.png"
        onClicked: {
          // Log calls to v-play.net
          flurry.logEvent("V-Play.net")
          flurry.logEvent("V-Play.net - particle editor features")
        }
        Text {
          anchors.centerIn: parent
          text: "Particle Editor - Features"
          color: "#b9ff0a"
        }
      }

      Column {
        x: 45
        y: 70
        spacing: 7
        AboutButton {
          sourceNormal: "../assets/img/item.png"
          sourceHover: "../assets/img/item.png"
          sourceClick: "../assets/img/item.png"
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Export JSON for usage in V-Play"
            color: "white"
            font.pixelSize: 12
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/item.png"
          sourceHover: "../assets/img/item.png"
          sourceClick: "../assets/img/item.png"
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Export .plist for usage in ..."
            color: "white"
            font.pixelSize: 12
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/item.png"
          sourceHover: "../assets/img/item.png"
          sourceClick: "../assets/img/item.png"
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Create and test particles directly on target device"
            color: "white"
            font.pixelSize: 12
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/item.png"
          sourceHover: "../assets/img/item.png"
          sourceClick: "../assets/img/item.png"
          Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 45
            text: "Use predefined particles and create your own ones"
            color: "white"
            font.pixelSize: 12
          }
        }
      }
    }
  }

  Item {
    id: about4
    Item {
      width: contentPanel.width
      height: contentPanel.height

      AboutButton {
        id: title
        x: 78
        y: 16
        sourceNormal: "../assets/img/title_normal.png"
        sourceHover: "../assets/img/title_hover.png"
        sourceClick: "../assets/img/title_click.png"
        onClicked: {
          // Log calls to v-play games
          flurry.logEvent("V-Play Games")
          nativeUtils.openUrl("http://www.v-play.net/showcases")
        }
        Text {
          anchors.centerIn: parent
          text: "V-Play Games"
          color: "#b9ff0a"
        }
      }

      Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: title.bottom
        anchors.topMargin: 15
        spacing: 7

        AboutButton {
          sourceNormal: "../assets/img/squaby_normal.png"
          sourceHover: "../assets/img/squaby_hover.png"
          sourceClick: "../assets/img/squaby_click.png"
          onClicked: {
            // Log calls to v-play games
            flurry.logEvent("V-Play Games Squaby")
            nativeUtils.openUrl("http://games.v-play.net/squaby/")
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/cob_normal.png"
          sourceHover: "../assets/img/cob_hover.png"
          sourceClick: "../assets/img/cob_click.png"
          onClicked: {
            // Log calls to v-play games
            flurry.logEvent("V-Play Games Chickenoutbreak")
            nativeUtils.openUrl("http://games.v-play.net/chickenoutbreak/")
          }
        }
        AboutButton {
          sourceNormal: "../assets/img/link_normal.png"
          sourceHover: "../assets/img/link_hover.png"
          sourceClick: "../assets/img/link_click.png"
          onClicked: {
            // Log calls to v-play games
            flurry.logEvent("V-Play Games")
            nativeUtils.openUrl("http://www.v-play.net/showcases")
          }
          Text {
            anchors.centerIn: parent
            text: "for more games click here"
            color: "#b9ff0a"
          }
        }
      }
    }
  }


  NumberAnimation on x {id: numberAnimationXR; running: false; duration: 500;
    onRunningChanged: {
      if(!running) {
        contentPanel.finishedAnimation()
      }
    }
  }
  NumberAnimation on x {id: numberAnimationXL; running: false; duration: 500;
    onRunningChanged: {
      if(!running) {
        contentPanel.finishedAnimation()
      }
    }
  }

  function moveLeft() {
    if(x < 0) {
      x = slideWidth
    }
    if(x === 0) {
       numberAnimationXL.to = -slideWidth
    }
    if(x > 0) {
      numberAnimationXL.to = 0
      panelNumber = aboutPanelNumber
    }
    numberAnimationXL.start()
  }

  function moveRight() {
    if(x > 0) {
      x = -slideWidth
    }
    if(x === 0) {
      numberAnimationXR.to = slideWidth
    }
    if(x < 0) {
      numberAnimationXR.to = 0
      panelNumber = aboutPanelNumber
    }
    numberAnimationXR.start()
  }
}
