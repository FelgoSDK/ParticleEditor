import VPlay 1.0
import QtQuick 1.1
import VPlay.plugins.flurry 1.0

GameWindow {
  id: window
  // depending on which window size is defined as start resolution here, the corresponding image sizes get loaded here! so for testing hd2 images, at least use factor 3.5
  // the window size can be changed at runtime by pressing the keys 1-6 (see GameWindow.qml)
  width: 480*2//*1.5 // for testing on desktop with the highest res, use *1.5 so the -hd2 textures are used
  height: 320*2//*1.5

  // enable FPS in release mode
  displayFpsEnabled: true

  // The entity manager needs to be defined before the scene, so it is available
  // during the destruction phase of the scene.
  EntityManager {
    id: entityManager
    entityContainer: scene
  }

  maximizeable: true
  resizeable: true

  // The alias is needed so every EditableComponent knows the itemEditor.
  // EditableComponents are used in Entities which are created by the EntityManager.
  property alias itemEditor: scene.itemEditor

  // The game scene which includes everything presented on screen
  ParticleEditorScene {
    id: scene
  }

  // Flurry is only avaialable on iOS and Android
  Flurry {
    id: flurry
    // this is the app key for the ParticleEditor-SDK-Demo, it is not the one used for the real app (which is not official)
    applicationKey: "WSM68XXM8PBJWBXZYBYM"
  }

  Component.onCompleted: {
    var isFirstStartApplication = settings.getValue("firstStart")
    if(isFirstStartApplication == undefined) {
      // now the application was started at least once, so set the flag to true
      settings.setValue("firstStart", true)
      //flurry.logTimedEvent("Start")
      flurry.logEvent("FirstStart");
    }
  }
}

