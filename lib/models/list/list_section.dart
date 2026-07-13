import 'package:uuid/uuid.dart';

import 'list_template_item.dart';

/// A container that groups your list items into sections.
/// https://developer.apple.com/documentation/carplay/cplistsection
/// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
class CPListSection {
  /// Unique id of the object.
  final String _elementId;

  /// The section’s header text.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final String? header;

  /// The section’s index title.
  /// Defaults to true.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final bool? sectionIndexEnabled;

  /// An explicit index title for the side scrubber, shown even when the
  /// section has no visible [header]. When null, the [header] is used.
  /// Ignored when [sectionIndexEnabled] is false.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final String? sectionIndexTitle;

  /// The list of items for the section.
  /// iOS 12.0+ | iPadOS 12.0+ | Mac Catalyst 13.1+
  final List<CPListTemplateItem> items;

  /// Creates [CPListSection] that contains zero or more list items. You can configure
  /// a section to display a header, which CarPlay displays on the trailing edge of the screen.
  CPListSection({
    this.header,
    this.sectionIndexEnabled,
    this.sectionIndexTitle,
    required List<CPListTemplateItem> items,
    String? id,
  })  : items = List<CPListTemplateItem>.from(items),
        _elementId = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() => {
        '_elementId': _elementId,
        'header': header,
        'items': items.map((e) => e.toJson()).toList(),
        'sectionIndexEnabled': sectionIndexEnabled,
        'sectionIndexTitle': sectionIndexTitle,
        'runtimeType': 'FCPListSection',
      };

  String get uniqueId {
    return _elementId;
  }
}
