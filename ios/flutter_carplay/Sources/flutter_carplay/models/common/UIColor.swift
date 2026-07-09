import UIKit

extension UIColor {
  // Parses an RRGGBB hex string, returning nil for anything malformed.
  convenience init?(fcpHex: String) {
    guard fcpHex.count == 6, let value = UInt32(fcpHex, radix: 16) else {
      return nil
    }
    self.init(
      red: CGFloat((value >> 16) & 0xFF) / 255.0,
      green: CGFloat((value >> 8) & 0xFF) / 255.0,
      blue: CGFloat(value & 0xFF) / 255.0,
      alpha: 1.0)
  }

  convenience init?(from dict: [String: Any]) {
    guard let red = UIColor.colorComponent(dict["red"]),
      let green = UIColor.colorComponent(dict["green"]),
      let blue = UIColor.colorComponent(dict["blue"]),
      let alpha = UIColor.alphaComponent(dict["alpha"])
    else { return nil }

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }

  private static func colorComponent(_ value: Any?) -> CGFloat? {
    guard let raw = numberValue(value) else { return nil }
    return min(max(raw, 0), 255) / 255
  }

  private static func alphaComponent(_ value: Any?) -> CGFloat? {
    guard let raw = numberValue(value) else { return nil }
    let normalized = raw > 1 ? raw / 255 : raw
    return min(max(normalized, 0), 1)
  }

  private static func numberValue(_ value: Any?) -> CGFloat? {
    if let value = value as? NSNumber {
      return CGFloat(truncating: value)
    }
    if let value = value as? Double {
      return CGFloat(value)
    }
    if let value = value as? Int {
      return CGFloat(value)
    }
    if let value = value as? CGFloat {
      return value
    }
    return nil
  }
}
