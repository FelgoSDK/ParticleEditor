import VPlay 1.0
import QtQuick 1.1

Button {
  id: button
  anchors.horizontalCenter: parent.horizontalCenter

  property bool dataStorageLocation: false

  onClicked: {
    if(dataStorageLocation) {
      parent.parent.editableType = text
      parent.parent.dataStorageLocation = dataStorageLocation
    } else {
      parent.editableType = text
      parent.dataStorageLocation = dataStorageLocation
    }


  }
}
