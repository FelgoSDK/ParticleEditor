/*
  This style enables the GUI Elements and ItemEditor styles from VPlay 1.0.
  */
import VPlay 2.0
import QtQuick 2.0
import QtQuick.Controls.Styles 1.1

Item {
  /*!
    This alias is used to access the buttonStyle. Used for instance in ButtonVPlay to assign the StyleVPlay to the QtQuick Controls Button element.
    \sa ButtonVPlay
  */
  property alias buttonStyle:buttonStyleComponent

  /*!
    This alias is used to access the switchStyle. Used for instance in SwitchVPlay to assign the StyleVPlay to the QtQuick Controls Switch element.
    \sa SwitchVPlay
  */
  property alias switchStyle:switchStyleComponent

  /*!
    This alias is used to access the sliderStyle. Used for instance in SliderVPlay to assign the StyleVPlay to the QtQuick Controls Slider element.
    \sa SliderVPlay
  */
  property alias sliderStyle:sliderStyleComponent

  /*!
    This alias is used to access the textFieldStyle. Used for instance in TextFieldVPlay to assign the StyleVPlay to the QtQuick Controls TextField element.
    \sa TextFieldVPlay
  */
  property alias textFieldStyle:textFieldStyleComponent

  /*!
    This alias is used to access the scrollViewStyle. Used for instance in ScrollViewVPlay to assign the StyleVPlay to the QtQuick ScrollView element.
    \sa ScrollViewVPlay
  */
  property alias scrollViewStyle:scrollViewStyleComponent

  /*!
    This alias is used to access the itemEditorStyle. Used for instance in ItemEditor to assign the StyleVPlay to the QtQuick GUI elements.
    \sa ItemEditor
    \sa ItemEditorStyle
  */
  property alias itemEditorStyle:itemEditorStyle

  /*!
    This property is used to change the color of the window background in GUI elements and in the ItemEditor.
    \sa ItemEditor
    \sa ItemEditorStyle
  */
  property color windowBackgroundColor: "#212126"

  /*!
    This property is used to change the color of the background in GUI elements.
  */
  property color elementBackgroundColor: "#2c2b2a"

  /*!
    This property is used to change the color of the foreground in GUI elements.
  */
  property color elementForegroundColor: "#413d3c"

  /*!
    This property is used to change the color of the highlight effects in GUI elements.
  */
  property color elementHighlightColor: Qt.lighter("#468bb7", 1.2)

  /*!
    This property is used to change the color of the highlight effects when the element is not hovered or pressed in GUI elements.
  */
  property color elementNormalColor: Qt.darker("#468bb7", 1.4)

  /*!
    This property is used to change the color of the ButtonVPlay text.
  */
  property color buttonTextColor: "white"

  /*!
    This property is used to change the pixel size of the ButtonVPlay text.
  */
  property int buttonTextPixelSize: 12

  /*!
    This property is used to change the color of the SwitchVPlay text.
  */
  property color switchTextColor: "white"

  /*!
    This property is used to change the pixel size of the SwitchVPlay text.
  */
  property int switchTextPixelSize: 11

  /*!
    This property is used to change the color of the TextFieldVPlay text.
  */
  property color textFieldTextColor: "white"

  /*!
    This property is used to change the color of the placeholder text of the TextFieldVPlay.
  */
  property color textFieldPlaceholderTextColor: "grey"

  /*!
    This property is used to change the pixel size of the TextFieldVPlay text.
  */
  property int textFieldTextPixelSize: 14

  /*!
    This property is used to change the color of the itemEditor label text.
  */
  property color itemEditorLabelTextColor: "white"

  /*!
    This property is used to change the pixel size of the itemEditor label text.
  */
  property int itemEditorLabelTextPixelSize: 11

  /*!
    This alias is used to change the font of the itemEditor label.
  */
  property alias itemEditorLabel: itemEditorLabel

  // Button Style
  Component {
    id: buttonStyleComponent
    ButtonStyle {
      panel: MultiResolutionImage {
        implicitHeight: 27
        implicitWidth: 69
        scale: control.pressed ? 0.9 : 1
        source: "../assets/img/button.png"
        Text {
          text: control.text
          anchors.centerIn: parent
          color: buttonTextColor
          font.pixelSize: buttonTextPixelSize
          // causes bad fonts and other problems http://qt-project.org/forums/viewthread/22158
          //renderType: Text.NativeRendering
          renderType: Text.QtRendering
        }
      }
    }
  }


  // Switch Style
  Component {
    id: switchStyleComponent
    SwitchStyle {
      groove: Item {
        implicitHeight: 18
        implicitWidth: 54

        MultiResolutionImage {
          implicitHeight: 18
          implicitWidth: 78
          source: control.checked ? "../assets/img/switch-on.png" : "../assets/img/switch-off.png"
        }
      }
      handle: MultiResolutionImage {
        implicitHeight: 16
        implicitWidth: 25
        source: "../assets/img/switch-thumb.png"
      }
    }
  }


  // Slider Style
  Component {
    id: sliderStyleComponent
    SliderStyle {
      handle: MultiResolutionImage {
        implicitHeight: 38
        implicitWidth: 38
        source: "../assets/img/slider-handle.png"
      }

      groove: MultiResolutionImage {
        implicitHeight: 20
        implicitWidth: 185
        source: "../assets/img/slider-background.png"
        Rectangle {
          z: -1
          anchors.verticalCenter: parent.verticalCenter
          antialiasing: true
          radius: 1
          color: elementHighlightColor
          height: 4
          width: styleData.handlePosition+5
        }
      }
    }
  }


  // TextField Style
  Component {
    id: textFieldStyleComponent
    TextFieldStyle {
      renderType: Text.QtRendering
      textColor: textFieldTextColor
      font.pixelSize: textFieldTextPixelSize
      padding { top: 0 ; left: Math.round(control.__contentHeight/3) ; right: control.__contentHeight/3 ; bottom: 0 }

      background: Item {
        implicitHeight: 25
        implicitWidth: 160
        MultiResolutionImage {
          source: "../assets/img/textinput.png"
          implicitHeight: 6
          implicitWidth: 160
          anchors.bottom: parent.bottom
          anchors.left: parent.left
          anchors.right: parent.right
        }
      }
    }
  }


  // ScrollView Style
  Component {
    id: scrollViewStyleComponent
    ScrollViewStyle {
      transientScrollBars: true
      handle: Item {
        implicitWidth: 7
        implicitHeight: 13
        Rectangle {
          color: elementBackgroundColor
          anchors.fill: parent
          anchors.topMargin: 3
          anchors.leftMargin: 2
          anchors.rightMargin: 2
          anchors.bottomMargin: 3
          Rectangle {
            color: elementForegroundColor
            anchors.fill: parent
            anchors.topMargin: 1
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            anchors.bottomMargin: 1
          }
        }
      }
      scrollBarBackground: Item {
        implicitWidth: 7
        implicitHeight: 13
      }
    }
  }

  // ItemEditor Style
  ItemEditorStyle {
    id: itemEditorStyle
    contentDelegateBackground: MultiResolutionImage {
      source: "../assets/img/window.png"
      anchors.fill: parent
    }
    contentDelegateTypeList: MultiResolutionImage {
      source: "../assets/img/window.png"
      anchors.fill: parent
    }
    label: Text {
      id: itemEditorLabel
      color: itemEditorLabelTextColor
      font.pixelSize: itemEditorLabelTextPixelSize
    }
  }
}
