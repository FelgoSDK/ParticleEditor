import VPlay 1.0
import QtQuick 1.1

EntityBase {
  id: particleEntity
  entityType: "particleEntity"

  // we can not access utils from gamewindow here
  Utils {
    id: ut
  }

  // default particle Type which should be loaded
  property string particleType: "FireParticle.json"
  property bool dataStorageLocation: false
  property bool entityBaseVisible: true

  // The red spot which is used to find an finished particle
  Rectangle {
    anchors.centerIn: parent
    width: 20
    height: 20
    opacity: 0.2
    color: "red"
    visible: entityBaseVisible
  }

  Particle {
    id: entityParticle

    autoStart: true

    fileName: dataStorageLocation ?
                fileUtils.getDataStorageUrl(system.getConfigValue("title")+"/particles/"+particleType) :
              particleType

    // The EditableComponent is used by the Particle Editor for automatic generation of the property GUI.
    // It is not needed for particles which finished and added to a game.
    EditableComponent {
      id: editableEditorComponent
      target: entityParticle
      editableType: ut.cropPath(particleType, true)
      defaultGroup: editableType // currently needed to save the files correctly.
      editableComponentMetaData: {
        "displayname" : editableType,
      }
      keepOneInstanceInMemory: false
      properties: {
        "Emitter Location": {
          "x": {"min": 0, "max": typeof scene.gameWindowAnchor !== "undefined" ? scene.gameWindowAnchor.width : 480, "label": "Position X"},
          "y": {"min": 0, "max": typeof scene.gameWindowAnchor !== "undefined" ? scene.gameWindowAnchor.height : 320, "label": "Position Y"},
          "sourcePositionVariance":     {"min": {x:0,y:0}, "max": {x:1000,y:1000}, "invert": {x:false,y:true}, "label": "Position Variance"}
        },

        "Particle Configuration": {
          "maxParticles":               {"min": 0, "max": 2000, "label": "Particle Count", "color": "red"},
          "particleLifespan":           {"min": 0, "max": 10, "stepsize": 0.01, "label": "Lifespan", "color": "red"},
          "particleLifespanVariance":   {"min": 0, "max": 10, "stepsize": 0.01, "label": "Lifespan Variance"},
          "startParticleSize":          {"min": 0, "max": 512, "label": "Start Size"},
          "startParticleSizeVariance":  {"min": 0, "max": 512, "label": "Start Size Variance"},
          "finishParticleSize":         {"min": 0, "max": 512, "label": "End Size"},
          "finishParticleSizeVariance": {"min": 0, "max": 512, "label": "End Size Variance"},
          "rotation":                   {"min": 0, "max": 360, "label": "Emit Angle"},
          "angleVariance":              {"min": 0, "max": 360, "label": "Emit Angle Variance"},
          "rotationStart":              {"min": -360, "max": 360, "label": "Start Spin"},
          "rotationStartVariance":      {"min": -360, "max": 360, "label": "Start Spin Variance"},
          "rotationEnd":                {"min": -360, "max": 360, "label": "End Spin"},
          "rotationEndVariance":        {"min": -360, "max": 360, "label": "End Spin Variance"}
        },

        "Emitter Behaviour": {
          "emitterType":                {"min": Particle.Gravity, "max": Particle.Radius, "stepsize": 1, "label": "Particle Mode"},
          "duration":                   {"min": Particle.Infinite, "max": 10, "stepsize": 0.01, "label": "Duration"},
          "positionType":               {"min": Particle.Free, "max": Particle.Grouped, "stepsize": 1, "label": "Position Type"},
          "visible": {"label": "Visible"}
        },

        // Gravity Mode (Gravity + Tangential Accel + Radial Accel)
        "Gravity Mode": {
          "gravity":                    {"min": {x:-1000,y:-1000}, "max": {x:1000,y:1000}, "label": "Gravity"},
          "speed":                      {"min": 0, "max": 1000, "label": "Speed", "color": "red"},
          "speedVariance":              {"min": 0, "max": 1000, "label": "Speed Variance"},
          "tangentialAcceleration":     {"min": -1000, "max": 1000, "label": "Tangential Acc."},
          "tangentialAccelVariance":    {"min": -1000, "max": 1000, "label": "Tangential Acc. Variance"},
          "radialAcceleration":         {"min": -1000, "max": 1000, "label": "Radial Acc."},
          "radialAccelVariance":        {"min": -1000, "max": 1000, "label": "Radial Acc. Variance"}
        },

        // Radiation Mode (circular movement)
        "Radiation Mode": {
          "minRadius":                  {"min": 0, "max": 512, "label": "Minimal Radius"},
          "minRadiusVariance":          {"min": 0, "max": 512, "label": "Minimal Radius Variance"},
          "maxRadius":                  {"min": 0, "max": 512, "label": "Maximal Radius"},
          "maxRadiusVariance":          {"min": 0, "max": 512, "label": "Maximal Radius Variance"},
          "rotatePerSecond":            {"min": 0, "max": 360, "label": "Rotation/s"},
          "rotatePerSecondVariance":    {"min": 0, "max": 360, "label": "Rotation/s Variance"},
        },

        "Color": {
          "startColor":                 {"min": 0, "max": 255,"stepsize": 1, "label": "Start Color"},
          "startColorAlpha":            {"min": 0, "max": 1,"stepsize": 0.1, "label": "Start Opacity"},
          "startColorVariance":         {"min": 0, "max": 255,"stepsize": 1, "label": "Start Color Variance"},
          "startColorVarianceAlpha":    {"min": 0, "max": 1,"stepsize": 0.1, "label": "Start Opacity Variance"},
          "finishColor":                {"min": 0, "max": 255,"stepsize": 1, "label": "End Color"},
          "finishColorAlpha":           {"min": 0, "max": 1,"stepsize": 0.1, "label": "End Opacity"},
          "finishColorVariance":        {"min": 0, "max": 255,"stepsize": 1, "label": "End Color Variance"},
          "finishColorVarianceAlpha":   {"min": 0, "max": 1,"stepsize": 0.1, "label": "End Opacity Variance"}
        },

        "Appearance": {
          "blendFuncSource":            {"min": Particle.GL_ONE, "max": Particle.GL_ONE_MINUS_SRC_ALPHA, "label": "Blend Source"},
          "blendFuncDestination":       {"min": Particle.GL_ONE, "max": Particle.GL_ONE_MINUS_SRC_ALPHA, "label": "Blend Destination"},
          "textureFileName":            {"label": "Texture"}
        }
      }
    }
  }

  function respawnParticle() {
    entityParticle.stopLivingParticles()
    entityParticle.start()
  }

  function stopParticle() {
    entityParticle.stopLivingParticles()
  }

  function sendParticlePerMail(mailto) {
    scene.itemEditor.saveItem(system.getConfigValue("title")+"/particles/",ut.cropPath(particleType, true))

    var messageMailto = mailto
    var messageSubject = particleType
    var messageBody = fileUtils.readFile(fileUtils.getDataStorageUrl(system.getConfigValue("title")+"/particles/"+particleType))

    // Use sendEmail method here instead of openUrl because of proper char escaping
    nativeUtils.sendEmail(mailto, messageSubject, messageBody);
  }


  function printParticle() {
    var buffer = editableEditorComponent.toJSON()
    console.debug(buffer)
  }

  function saveToPList() {
    entityParticle.saveAsPList(system.getConfigValue("title")+"/particles/"+ut.cropPath(particleType, true)+".plist")
  }

  function sendParticlePListPerMail(mailto) {
    var filenameWithPlistInsteadJson = ut.cropPath(particleType, true) + ".plist"
    entityParticle.saveAsPList(system.getConfigValue("title")+"/particles/" + filenameWithPlistInsteadJson)

    var messageMailto = mailto
    var messageSubject = filenameWithPlistInsteadJson
    var messageBody = fileUtils.readFile(fileUtils.getDataStorageUrl(system.getConfigValue("title")+"/particles/" + filenameWithPlistInsteadJson))

    // Use sendEmail method here instead of openUrl because of proper char escaping
    nativeUtils.sendEmail(mailto, messageSubject, messageBody);
  }
} // end of EntityBase
