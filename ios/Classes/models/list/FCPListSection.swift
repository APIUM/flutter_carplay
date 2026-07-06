//
//  FCPListSection.swift
//  flutter_carplay
//
//  Created by Oğuzhan Atalay on 21.08.2021.
//

import CarPlay

@available(iOS 14.0, *)
class FCPListSection {
  private(set) var _super: CPListSection?
  private(set) var elementId: String
  private var header: String?
  private var items: [CPListTemplateItem]
  /// Contains FCPListItem and FCPListImageRowItem instances, in display order.
  private var objcItems: [Any]
  private var sectionIndexEnabled: Bool

  init(obj: [String : Any], sectionIndexEnabled: Bool = true) {
    self.elementId = obj["_elementId"] as! String
    self.header = obj["header"] as? String
    self.sectionIndexEnabled = sectionIndexEnabled
    self.objcItems = (obj["items"] as! Array<[String : Any]>).map { itemObj -> Any in
      if itemObj["runtimeType"] as? String == "FCPListImageRowItem" {
        return FCPListImageRowItem(obj: itemObj)
      }
      return FCPListItem(obj: itemObj)
    }
    self.items = self.objcItems.map { item -> CPListTemplateItem in
      if let imageRowItem = item as? FCPListImageRowItem {
        return imageRowItem.get
      }
      return (item as! FCPListItem).get
    }
  }

  var get: CPListSection {
    let indexTitle = sectionIndexEnabled ? header : nil
    let listSection = CPListSection.init(items: items, header: header, sectionIndexTitle: indexTitle)
    self._super = listSection
    return listSection
  }

  public func getItems() -> [FCPListItem] {
    return objcItems.compactMap { $0 as? FCPListItem }
  }

  public func getImageRowItems() -> [FCPListImageRowItem] {
    return objcItems.compactMap { $0 as? FCPListImageRowItem }
  }

  public func merge(with: FCPListSection) -> FCPListSection {
    let copy = with
    self.updateItems(items: copy.objcItems)
    copy._super = self._super
    copy.objcItems = self.objcItems;
    copy.items = self.items;
    return copy;
  }

  /// Replaces the section's items with the given items (list rows and/or
  /// image rows, in display order).
  ///
  /// [FCPListItem]s matched by elementId to an existing instance keep their
  /// native identity and any in-flight tap completion handler. Image row
  /// items (and any list item not previously present) are (re)created fresh
  /// -- image rows don't currently support incremental updates, so they're
  /// always rebuilt when a section is merged.
  public func updateItems(items: [Any]) {
    let fcpListTemplateItem: [String: FCPListItem] = Dictionary(
      uniqueKeysWithValues: self.getItems().map { ($0.elementId, $0) })
    let cpListTemplateItem: [String: CPListTemplateItem] = Dictionary(
      uniqueKeysWithValues: zip(self.objcItems, self.items).compactMap { objcItem, cpItem -> (String, CPListTemplateItem)? in
        guard let listItem = objcItem as? FCPListItem else { return nil }
        return (listItem.elementId, cpItem)
      })

    /// Keep Flutter CarPlay object if necessary, use new instance.
    self.objcItems = items.map { item -> Any in
      guard let listItem = item as? FCPListItem,
        let existing = fcpListTemplateItem[listItem.elementId]
      else {
        return item // Use new instance (image row item, or a never-seen-before list item)
      }
      return existing.merge(with: listItem) // Merge old instance with newest to keep some data (eg: completeHandler)
    }
    self.items = items.map { item -> CPListTemplateItem in
      if let listItem = item as? FCPListItem {
        if let existing = cpListTemplateItem[listItem.elementId] {
          return existing // Reuse existing CP template
        }
        return listItem.get // New CP template
      }
      return (item as! FCPListImageRowItem).get // Image rows are always rebuilt
    }
  }
}
