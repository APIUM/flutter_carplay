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
  private var objcItems: [FCPListTemplateItem]
  private var sectionIndexEnabled: Bool
  private var explicitSectionIndexTitle: String?

  init(obj: [String: Any]) {
    self.elementId = obj["_elementId"] as! String
    self.header = obj["header"] as? String
    self.sectionIndexEnabled = obj["sectionIndexEnabled"] as? Bool ?? true
    self.explicitSectionIndexTitle = obj["sectionIndexTitle"] as? String
    self.objcItems = (obj["items"] as! [[String: Any]]).map { dict -> FCPListTemplateItem in
      guard let runtimeType = dict["runtimeType"] as? String else {
        fatalError("FCPListSection.init: Missing runtimeType in item")
      }

      if runtimeType == "FCPListImageRowItem" {
        return FCPListImageRowItem(obj: dict) as FCPListTemplateItem
      } else if runtimeType == "FCPListItem" {
        return FCPListItem(obj: dict) as FCPListTemplateItem
      } else {
        fatalError("FCPListSection.init: Unknown item runtimeType: \(runtimeType)")
      }
    }
    self.items = self.objcItems.map {
      $0.get
    }
  }

  var get: CPListSection {
    let sectionIndexTitle = sectionIndexEnabled ? (explicitSectionIndexTitle ?? header) : nil

    let listSection = CPListSection.init(
      items: items, header: header, sectionIndexTitle: sectionIndexTitle)

    self._super = listSection
    return listSection
  }

  /// Swaps freshly-parsed items for existing native instances sharing an
  /// elementId, so rows keep their already-loaded images across a sections
  /// update instead of flashing back to the placeholder.
  func reuseItems(from existing: [String: FCPListTemplateItem]) {
    objcItems = objcItems.map { existing[$0.elementId] ?? $0 }
    items = objcItems.map { item in
      if let listItem = item as? FCPListItem, let native = listItem._super {
        return native
      }
      if let rowItem = item as? FCPListImageRowItem, let native = rowItem._super {
        return native
      }
      return item.get
    }
  }

  public func getFCPListTemplateItems() -> [FCPListTemplateItem] {
    return objcItems
  }
}
