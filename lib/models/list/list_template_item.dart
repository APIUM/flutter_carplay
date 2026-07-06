/// Common interface for items that can appear in a [CPListSection]:
/// [CPListItem] and [CPListImageRowItem].
abstract class CPListTemplateItem {
  /// Returns the unique identifier for this item.
  String get uniqueId;

  /// Converts this item to a JSON representation for native communication.
  Map<String, dynamic> toJson();
}
