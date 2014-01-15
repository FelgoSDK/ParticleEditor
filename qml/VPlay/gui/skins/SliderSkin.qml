import QtQuick 1.1
import VPlay 1.0
import VPlay.gui 1.0

// uncomment to use overrider skin
SliderStyle {
  // Use some pink color for the slider
  valueTrackLeftMargin: 5
  valueTrackTopMargin: 8
  valueTrackBottomMargin: 9
  valueBackground: usingImage ? "../img/slider-handle-value-background-sd.png" : ""
  labelArrowDown: usingImage ? "../img/slider-handle-label-arrow-down.png" : ""
  labelArrowUp: usingImage ? "../img/slider-handle-label-arrow-up.png" : ""
  labelArrowLeft: usingImage ? "../img/slider-handle-label-arrow-left.png" : ""
  labelArrowRight: usingImage ? "../img/slider-handle-label-arrow-right.png" : ""
  handleBackground: usingImage ? "../img/slider-handle-sd.png" : ""
  grooveItemBackground: usingImage ? "../img/slider-background-sd.png" : ""
}
