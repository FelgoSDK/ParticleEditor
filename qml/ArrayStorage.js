var storageArray = new Array();

function getArray() {
  return storageArray
}

function hasElement(element) {
  for(var i = 0; i < storageArray.length; ++i) {
    if(storageArray[i] === element) {
      return storageArray[i]
    }
  }
  return false
}

function push(element) {
  storageArray.push(element)
}

function removeAll(destroyContent) {
  for(var i = 0; i < storageArray.length; ++i) {
    remove(storageArray[i],destroyContent)
  }
}

function remove(element, destroyContent) {
  for(var i = 0; i < storageArray.length; ++i) {
    if(destroyContent) {
      if(storageArray[i]) {
        storageArray[i].destroy()
      }
    }
    storageArray[i] = 0
  }
}
