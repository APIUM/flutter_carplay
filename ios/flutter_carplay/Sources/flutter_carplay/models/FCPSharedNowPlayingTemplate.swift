//
//  FCPSharedNowPlaying.swift
//  flutter_carplay
//
//  Created by Koen Van Looveren on 16/09/2022.
//

import CarPlay

@available(iOS 14.0, *)
class FCPSharedNowPlayingTemplate {
  private static var buttonInstances: [FCPNowPlayingButton] = []

  var get: CPTemplate {
    return CPNowPlayingTemplate.shared
  }

  init() {}

  /// Sets custom buttons on the Now Playing template.
  /// - Parameter buttons: Array of button dictionaries from Flutter
  static func setButtons(_ buttons: [[String: Any]]) {
    // Retain the wrapper instances so their handlers stay alive for the
    // lifetime of the configured buttons.
    buttonInstances = buttons.compactMap { FCPNowPlayingButtonFactory.createButton(from: $0) }

    DispatchQueue.main.async {
      CPNowPlayingTemplate.shared.updateNowPlayingButtons(buttonInstances.map { $0.get })
    }
  }

  public func update(with: any FCPTemplate) {
    guard let with = with as? FCPSharedNowPlayingTemplate else {
      return
    }
  }
}

@available(iOS 14.0, *)
extension FCPSharedNowPlayingTemplate: FCPTemplate {
  var elementId: String {
    return "FCPSharedNowPlayingTemplate"
  }
}
