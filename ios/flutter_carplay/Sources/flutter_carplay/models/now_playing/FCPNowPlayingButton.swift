//
//  FCPNowPlayingButton.swift
//  flutter_carplay
//

import CarPlay

/// A description of the common properties of all Now Playing button types.
@available(iOS 14.0, *)
public protocol FCPNowPlayingButton {
  var elementId: String { get }
  var get: CPNowPlayingButton { get }
}

/// Creates the concrete [FCPNowPlayingButton] wrapper for a button dictionary
/// sent from Flutter.
@available(iOS 14.0, *)
class FCPNowPlayingButtonFactory {
  static func createButton(from obj: [String: Any]) -> FCPNowPlayingButton? {
    guard let type = obj["type"] as? String else { return nil }

    switch type {
    case "repeat":
      return FCPNowPlayingRepeatButton(obj: obj)
    case "shuffle":
      return FCPNowPlayingShuffleButton(obj: obj)
    case "addToLibrary":
      return FCPNowPlayingAddToLibraryButton(obj: obj)
    case "more":
      return FCPNowPlayingMoreButton(obj: obj)
    case "playbackRate":
      return FCPNowPlayingPlaybackRateButton(obj: obj)
    case "image":
      return FCPNowPlayingImageButton(obj: obj)
    default:
      return nil
    }
  }
}

/// A button that cycles through repeat modes.
@available(iOS 14.0, *)
class FCPNowPlayingRepeatButton {
  private(set) var elementId: String

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
  }

  var get: CPNowPlayingButton {
    return CPNowPlayingRepeatButton(handler: { [weak self] _ in
      guard let self = self else { return }
      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onNowPlayingButtonPressed,
          data: ["elementId": self.elementId]
        )
      }
    })
  }
}

@available(iOS 14.0, *)
extension FCPNowPlayingRepeatButton: FCPNowPlayingButton {}

/// A button that toggles shuffle mode.
@available(iOS 14.0, *)
class FCPNowPlayingShuffleButton {
  private(set) var elementId: String

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
  }

  var get: CPNowPlayingButton {
    return CPNowPlayingShuffleButton(handler: { [weak self] _ in
      guard let self = self else { return }
      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onNowPlayingButtonPressed,
          data: ["elementId": self.elementId]
        )
      }
    })
  }
}

@available(iOS 14.0, *)
extension FCPNowPlayingShuffleButton: FCPNowPlayingButton {}

/// A button that adds the current item to the library.
@available(iOS 14.0, *)
class FCPNowPlayingAddToLibraryButton {
  private(set) var elementId: String

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
  }

  var get: CPNowPlayingButton {
    return CPNowPlayingAddToLibraryButton(handler: { [weak self] _ in
      guard let self = self else { return }
      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onNowPlayingButtonPressed,
          data: ["elementId": self.elementId]
        )
      }
    })
  }
}

@available(iOS 14.0, *)
extension FCPNowPlayingAddToLibraryButton: FCPNowPlayingButton {}

/// A button that triggers a "more" action.
@available(iOS 14.0, *)
class FCPNowPlayingMoreButton {
  private(set) var elementId: String

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
  }

  var get: CPNowPlayingButton {
    return CPNowPlayingMoreButton(handler: { [weak self] _ in
      guard let self = self else { return }
      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onNowPlayingButtonPressed,
          data: ["elementId": self.elementId]
        )
      }
    })
  }
}

@available(iOS 14.0, *)
extension FCPNowPlayingMoreButton: FCPNowPlayingButton {}

/// A button that cycles through playback rates.
@available(iOS 14.0, *)
class FCPNowPlayingPlaybackRateButton {
  private(set) var elementId: String

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
  }

  var get: CPNowPlayingButton {
    return CPNowPlayingPlaybackRateButton(handler: { [weak self] _ in
      guard let self = self else { return }
      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onNowPlayingButtonPressed,
          data: ["elementId": self.elementId]
        )
      }
    })
  }
}

@available(iOS 14.0, *)
extension FCPNowPlayingPlaybackRateButton: FCPNowPlayingButton {}

/// A custom image button for the Now Playing screen.
@available(iOS 14.0, *)
class FCPNowPlayingImageButton {
  private(set) var elementId: String
  private var image: String

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.image = obj["image"] as! String
  }

  var get: CPNowPlayingButton {
    let imageSource = self.image.toImageSource()
    let uiImage = makeUIImage(from: imageSource)

    return CPNowPlayingImageButton(image: uiImage, handler: { [weak self] _ in
      guard let self = self else { return }
      DispatchQueue.main.async {
        FCPStreamHandlerPlugin.sendEvent(
          type: FCPChannelTypes.onNowPlayingButtonPressed,
          data: ["elementId": self.elementId]
        )
      }
    })
  }
}

@available(iOS 14.0, *)
extension FCPNowPlayingImageButton: FCPNowPlayingButton {}
