import QtQuick 1.1
import VPlay 1.0
import VPlay.gui 1.0

SwitchStyle {
  switchOn: usingImage ? "../img/switch-on-sd.png" : ""
  switchOff: usingImage ? "../img/switch-off-sd.png" : ""
  thumb: usingImage ? "../img/slider-handle-sd.png" : ""
}
