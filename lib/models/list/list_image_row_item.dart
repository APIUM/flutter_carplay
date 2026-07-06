import 'package:flutter_carplay/models/list/list_template_item.dart';
import 'package:uuid/uuid.dart';

/// A list template row that displays a horizontally scrollable series of
/// tappable images.
/// https://developer.apple.com/documentation/carplay/cplistimagerowitem
/// iOS 14.0+ | iPadOS 14.0+ | Mac Catalyst 14.0+
class CPListImageRowItem implements CPListTemplateItem {
  /// Unique id of the object.
  final String _elementId = const Uuid().v4();

  /// Text displayed with the image row, typically as its title.
  final String text;

  /// The images that appear in the row, in leading-to-trailing order.
  ///
  /// Each entry supports four formats:
  /// - **Asset path**: `images/cover.png` (from pubspec.yaml assets)
  /// - **File path**: `file:///path/to/image.png` (local file on device)
  /// - **Network URL**: `https://example.com/image.png` (remote image)
  /// - **SF Symbol**: `sfsymbol:music.note.list` (iOS system symbol by name)
  ///
  /// CarPlay silently truncates the row to the platform's
  /// `CPMaximumNumberOfGridImages` limit, which varies by device/screen size
  /// rather than being a fixed number -- any images beyond that limit are
  /// dropped (indices are preserved for the images that are kept, so
  /// [onItemPress]'s index still lines up with this list). Keep this list
  /// short (e.g. 6 or fewer) so it fits comfortably on smaller displays.
  final List<String> images;

  /// An optional callback function that CarPlay invokes when the user selects
  /// one of the images. [index] is the position of the selected image within
  /// [images]. Call [complete] when the action has been handled to dismiss
  /// the item's loading indicator.
  final Function(Function() complete, CPListImageRowItem self, int index)?
      onItemPress;

  /// Creates a [CPListImageRowItem] with a title and a horizontally
  /// scrollable row of images.
  CPListImageRowItem({
    required this.text,
    required this.images,
    this.onItemPress,
  });

  @override
  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'text': text,
        'images': images,
        'onItemPress': onItemPress != null ? true : false,
        'runtimeType': 'FCPListImageRowItem',
      };

  @override
  String get uniqueId {
    return _elementId;
  }
}
