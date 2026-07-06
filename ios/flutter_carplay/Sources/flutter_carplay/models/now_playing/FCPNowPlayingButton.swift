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

/// Builds the matching `FCPNowPlayingButton` for a button dictionary
/// sent from Flutter.
@available(iOS 14.0, *)
class FCPNowPlayingButtonFactory {
  static func createButton(from obj: [String: Any]) -> FCPNowPlayingButton? {
    guard let type = obj["type"] as? String else { return nil }

    switch type {
    case "repeat":
      return FCPNowPlayingSystemButton(obj: obj) { CPNowPlayingRepeatButton(handler: $0) }
    case "shuffle":
      return FCPNowPlayingSystemButton(obj: obj) { CPNowPlayingShuffleButton(handler: $0) }
    case "addToLibrary":
      return FCPNowPlayingSystemButton(obj: obj) { CPNowPlayingAddToLibraryButton(handler: $0) }
    case "more":
      return FCPNowPlayingSystemButton(obj: obj) { CPNowPlayingMoreButton(handler: $0) }
    case "playbackRate":
      return FCPNowPlayingSystemButton(obj: obj) { CPNowPlayingPlaybackRateButton(handler: $0) }
    case "image":
      return FCPNowPlayingImageButton(obj: obj)
    default:
      return nil
    }
  }
}

/// A system-provided Now Playing button that reports taps back to Flutter.
@available(iOS 14.0, *)
class FCPNowPlayingSystemButton {
  private(set) var elementId: String
  private let makeButton: (@escaping (CPNowPlayingButton) -> Void) -> CPNowPlayingButton

  init(
    obj: [String: Any],
    makeButton: @escaping (@escaping (CPNowPlayingButton) -> Void) -> CPNowPlayingButton
  ) {
    self.elementId = obj["_elementId"] as! String
    self.makeButton = makeButton
  }

  var get: CPNowPlayingButton {
    return makeButton({ [weak self] _ in
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
extension FCPNowPlayingSystemButton: FCPNowPlayingButton {}

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
