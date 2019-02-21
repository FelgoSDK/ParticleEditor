import Felgo 3.0
import QtQuick 2.2

Item {
  property alias particle: internParticle
  Particle {
    id: internParticle
    fileName: "AboutFlames.json"
    autoStart: true
  }
}
