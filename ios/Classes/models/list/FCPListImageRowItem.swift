//
//  FCPListImageRowItem.swift
//  flutter_carplay
//
//  Backported (simplified) from upstream master for the finamp fork.
//

import CarPlay

@available(iOS 14.0, *)
class FCPListImageRowItem {
  private(set) var _super: CPListImageRowItem?
  private(set) var elementId: String
  private var text: String
  private var images: [String]
  private var isOnItemPressListenerActive: Bool
  private var completeItemHandler: (() -> Void)?

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.text = obj["text"] as? String ?? ""
    self.images = obj["images"] as? [String] ?? []
    self.isOnItemPressListenerActive = obj["onItemPress"] as? Bool ?? false
  }

  var get: CPListImageRowItem {
    // Create the item with placeholders, then resolve each image
    // asynchronously and update in place. The system truncates the row to
    // CPMaximumNumberOfGridImages, so iterate over the truncated count.
    let placeholders = Array(repeating: makeSafeUIPlaceholder(), count: images.count)
    let listImageRowItem = CPListImageRowItem(text: text, images: placeholders)

    let maxCount = listImageRowItem.gridImages.count
    for (index, imagePath) in images.prefix(maxCount).enumerated() {
      let imageSource = imagePath.toImageSource()
      loadUIImageAsync(from: imageSource) { uiImage in
        guard let uiImage = uiImage else { return }
        var currentImages = listImageRowItem.gridImages
        guard currentImages.indices.contains(index) else { return }
        currentImages[index] = uiImage
        listImageRowItem.update(currentImages)
      }
    }

    if isOnItemPressListenerActive {
      listImageRowItem.listImageRowHandler = { [weak self] _, index, complete in
        guard let self = self else {
          complete()
          return
        }
        self.completeItemHandler = complete
        DispatchQueue.main.async {
          FCPStreamHandlerPlugin.sendEvent(
            type: FCPChannelTypes.onListImageRowItemElementSelected,
            data: ["elementId": self.elementId, "index": index]
          )
        }
      }
    }

    self._super = listImageRowItem
    return listImageRowItem
  }

  public func stopItemHandler() {
    guard self.completeItemHandler != nil else {
      return
    }
    self.completeItemHandler!()
    self.completeItemHandler = nil
  }
}
