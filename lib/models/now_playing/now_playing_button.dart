import 'package:uuid/uuid.dart';

/// A description of the common properties of all Now Playing button types.
/// https://developer.apple.com/documentation/carplay/cpnowplayingbutton
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
abstract class CPNowPlayingButton {
  /// A closure that CarPlay invokes when the user taps the button.
  Function()? get onPress;

  Map<String, dynamic> toJson();

  String get uniqueId;
}

/// A button that cycles through repeat modes on the Now Playing screen.
/// https://developer.apple.com/documentation/carplay/cpnowplayingrepeatbutton
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPNowPlayingRepeatButton extends CPNowPlayingButton {
  /// Unique id of the object.
  final String _elementId;

  /// A closure that CarPlay invokes when the user taps the button.
  @override
  final Function()? onPress;

  /// Creates [CPNowPlayingRepeatButton]
  CPNowPlayingRepeatButton({
    this.onPress,
    String? id,
  }) : _elementId = id ?? const Uuid().v4();

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'type': 'repeat',
      };

  @override
  String get uniqueId => _elementId;
}

/// A button that toggles shuffle mode on the Now Playing screen.
/// https://developer.apple.com/documentation/carplay/cpnowplayingshufflebutton
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPNowPlayingShuffleButton extends CPNowPlayingButton {
  /// Unique id of the object.
  final String _elementId;

  /// A closure that CarPlay invokes when the user taps the button.
  @override
  final Function()? onPress;

  /// Creates [CPNowPlayingShuffleButton]
  CPNowPlayingShuffleButton({
    this.onPress,
    String? id,
  }) : _elementId = id ?? const Uuid().v4();

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'type': 'shuffle',
      };

  @override
  String get uniqueId => _elementId;
}

/// A button that adds the currently playing item to the user's library.
/// https://developer.apple.com/documentation/carplay/cpnowplayingaddtolibrarybutton
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPNowPlayingAddToLibraryButton extends CPNowPlayingButton {
  /// Unique id of the object.
  final String _elementId;

  /// A closure that CarPlay invokes when the user taps the button.
  @override
  final Function()? onPress;

  /// Creates [CPNowPlayingAddToLibraryButton]
  CPNowPlayingAddToLibraryButton({
    this.onPress,
    String? id,
  }) : _elementId = id ?? const Uuid().v4();

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'type': 'addToLibrary',
      };

  @override
  String get uniqueId => _elementId;
}

/// A button that triggers a "more" action, typically presenting additional
/// options for the currently playing item.
/// https://developer.apple.com/documentation/carplay/cpnowplayingmorebutton
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPNowPlayingMoreButton extends CPNowPlayingButton {
  /// Unique id of the object.
  final String _elementId;

  /// A closure that CarPlay invokes when the user taps the button.
  @override
  final Function()? onPress;

  /// Creates [CPNowPlayingMoreButton]
  CPNowPlayingMoreButton({
    this.onPress,
    String? id,
  }) : _elementId = id ?? const Uuid().v4();

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'type': 'more',
      };

  @override
  String get uniqueId => _elementId;
}

/// A button that cycles through playback rate options on the Now Playing
/// screen.
/// https://developer.apple.com/documentation/carplay/cpnowplayingplaybackratebutton
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPNowPlayingPlaybackRateButton extends CPNowPlayingButton {
  /// Unique id of the object.
  final String _elementId;

  /// A closure that CarPlay invokes when the user taps the button.
  @override
  final Function()? onPress;

  /// Creates [CPNowPlayingPlaybackRateButton]
  CPNowPlayingPlaybackRateButton({
    this.onPress,
    String? id,
  }) : _elementId = id ?? const Uuid().v4();

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'type': 'playbackRate',
      };

  @override
  String get uniqueId => _elementId;
}

/// A custom image button for the Now Playing screen.
///
/// Use this for app specific actions that don't map to one of the system
/// button types, such as favorite/like or starting an instant mix.
/// https://developer.apple.com/documentation/carplay/cpnowplayingimagebutton
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPNowPlayingImageButton extends CPNowPlayingButton {
  /// Unique id of the object.
  final String _elementId;

  /// The image displayed on the button.
  ///
  /// Supports these formats:
  /// * Asset path: `images/heart.png` from pubspec.yaml assets
  /// * File path: `file:///path/to/image.png` local file on device
  /// * Network URL: `https://example.com/image.png` remote image
  /// * SF Symbol: `sfsymbol:heart.fill` iOS system symbol by name
  ///
  /// The image should be a template image that can be tinted by the system.
  /// Use a simple, single color image for best results. SF Symbols are
  /// template images by nature and are the recommended choice.
  final String image;

  /// A closure that CarPlay invokes when the user taps the button.
  @override
  final Function() onPress;

  /// Creates [CPNowPlayingImageButton]
  CPNowPlayingImageButton({
    required this.image,
    required this.onPress,
    String? id,
  }) : _elementId = id ?? const Uuid().v4();

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'type': 'image',
        'image': image,
      };

  @override
  String get uniqueId => _elementId;
}
