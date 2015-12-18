import VPlay 2.0
import QtQuick 2.2

Item {
  property alias particle: internParticle
  ParticleVPlay {
    id: internParticle
    fileName: "AboutFlames.json"
    autoStart: true
  }
}
