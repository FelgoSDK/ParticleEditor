import VPlay 1.0
import QtQuick 1.1
import "particles"
Item {
  id: about
  width: gameWindowAnchorItem.width
  height: gameWindowAnchorItem.height

  property bool closed: true

  function closePanel() {
    if(!aboutPane.visible)
      return

    // Log open about panel
    flurry.logEvent("OpenAbout")

    aboutPane.transform()
    clipping.transform()
  }


  Item {
    id: aboutPane
    width: parent.width
    height: 0
    visible: false


    onHeightChanged: {
      if(height <= 0) {
        aboutPane.visible = false
      } else {
        aboutPane.visible = true
      }
    }


    Clipping {
      id: aboutImage
      height: aboutPane.height+10
      width: aboutPane.width

      SpriteBatchContainer {
      }

      SingleSpriteFromFile {
        anchors.fill: parent

        translateToCenterAnchor: false

        filename: "img/aboutscreen-sd.json"
        source: "background.png"
      }



      property int aboutPanelNumber: 1
      onAboutPanelNumberChanged: {
        if(aboutPanelNumber<1) {
          aboutPanelNumber = 4
        }
        if(aboutPanelNumber > 4) {
          aboutPanelNumber = 1
        }
      }

      Item {
        anchors.horizontalCenter: parent.horizontalCenter
        width: firstContent.width
        height: firstContent.height
        AboutPanelContent {
          id: firstContent
          y: headerPlot.height
          aboutPanelNumber: aboutImage.aboutPanelNumber
          slideWidth: aboutImage.width
          panelNumber: 1
          onMoveToLeft: aboutImage.moveRight()
          onMoveToRight: aboutImage.moveLeft()
        }
        AboutPanelContent {
          id: secondContent
          y: headerPlot.height
          x: aboutImage.width
          aboutPanelNumber: aboutImage.aboutPanelNumber
          slideWidth: aboutImage.width
          panelNumber: 2
          onMoveToLeft: aboutImage.moveRight()
          onMoveToRight: aboutImage.moveLeft()
        }
      }

      function moveLeft() {
        aboutImage.aboutPanelNumber--
        firstContent.moveLeft()
        secondContent.moveLeft()
      }

      function moveRight() {
        aboutImage.aboutPanelNumber++
        firstContent.moveRight()
        secondContent.moveRight()
      }

      AboutParticle {
        x: parent.width/2
        y: parent.height
      }
      AboutParticle {
        y: headerPlot.height
        particle.fileName: "particles/Laser.json"
      }
    }

    function transform() {
      if(height <= 0) {
        tf.to = about.height
      } else if(height >= about.height) {
        tf.to = 0
      }
      tf.start()
    }
    NumberAnimation on height {id: tf; running: false; duration: 1000;}
  }

  Item {
    id: headerPlot
    width: 45
    height: 50
    anchors.horizontalCenter: parent.horizontalCenter
    Clipping {
      id: clipping
      width: parent.width
      height: parent.height

      MultiResolutionImage {
        id: imageHeader
        source: "img/vplay-logo-sd.png"
        MouseArea {
          anchors.fill: parent
          onClicked: {
            // only open if no panel is open
            if(!mainMenu.sliderOut)
              mainMenu.slide()
            if(!entityMenu.sliderOut)
              entityMenu.slide()

            aboutPane.transform()
            clipping.transform()
          }
        }
      }

      function transform() {
        if(width <= parent.width) {
          tfc.to = imageHeader.width
          tfcx.to = -imageHeader.width/2+headerPlot.width/2

          // disable particles
          var entities = entityManager.getEntityArrayByType("particleEntity")
          for(var i=0; i<entities.length; ++i) {
            entities[i].stopParticle()
          }
        } else if(width >= imageHeader.width) {
          tfc.to = parent.width
          tfcx.to = 0

          // enable particles again
          var entities = entityManager.getEntityArrayByType("particleEntity")
          for(var i=0; i<entities.length; ++i) {
            entities[i].respawnParticle()
          }
        }
        tfc.start()
        tfcx.start()
        sparkles.particle.start()
      }

      NumberAnimation on width {id: tfc; running: false; duration: 1000;
      }
      NumberAnimation on x {id: tfcx; running: false; duration: 1000;
        onRunningChanged: {
          if(!running) {
            sparkles.particle.stop()
          }
        }
      }
    }
    AboutParticle {
      z: clipping.z+2
      id: sparkles
      x: clipping.x+clipping.width
      y: clipping.y+clipping.height/2
      particle.fileName: "particles/AboutSparkle.json"
      particle.autoStart: false
    }
  }
}
