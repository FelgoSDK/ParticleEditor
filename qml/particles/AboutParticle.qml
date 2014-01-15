import VPlay 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
  property alias particle: internParticle
  Particle {
    id: internParticle
    fileName: "AboutFlames.json"
    autoStart: true
  }
}
