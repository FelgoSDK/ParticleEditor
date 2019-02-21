import Felgo 3.0
import QtQuick 2.2

GameWindow {
  id: window
  // depending on which window size is defined as start resolution here, the corresponding image sizes get loaded here! so for testing hd2 images, at least use factor 3.5
  // the window size can be changed at runtime by pressing the keys 1-6 (see GameWindow.qml)
  screenWidth: 480*2//*1.5 // for testing on desktop with the highest res, use *1.5 so the -hd2 textures are used
  screenHeight: 320*2//*1.5

  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  settings.style: ParticleEditorStyle {}

  // enable FPS in release mode
  //displayFpsEnabled: false

  // The entity manager needs to be defined before the scene, so it is available
  // during the destruction phase of the scene.
  EntityManager {
    id: entityManager
    entityContainer: scene
  }

  //maximizeable: true
  //resizeable: true

  // The alias is needed so every EditableComponent knows the itemEditor.
  // EditableComponents are used in Entities which are created by the EntityManager.
  property alias itemEditor: scene.itemEditor

  // The game scene which includes everything presented on screen
  ParticleEditorScene {
    id: scene
  }

  // Flurry is only available on iOS and Android
  Flurry {
    id: flurry
    apiKey: "WSM68XXM8PBJWBXZYBYM"
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

  // on desktop platforms we do not want to share the particles over all applications in the document directory so we add a subfolder using the title. On mobiles each app has its own doc dir anyway.
  function getInternalStorageLocation() {
    var particleLocation = ""
    if(system.isPlatform(System.Mac) || system.isPlatform(System.Linux) || system.isPlatform(System.Windows)) {
      particleLocation = system.getConfigValue("title")+"/particles/"
    } else {
      particleLocation = "particles/"
    }
    return particleLocation
  }
}

