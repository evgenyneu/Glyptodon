
import UIKit

/**

Default styles for the button.
Default styles are used when individual element styles are not set.

*/
public struct GlyptodonButtonDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    borderColor = _borderColor
    borderMargin = _borderMargin
    color = _color
    font = _font
    horizontalMargin = _horizontalMargin
    numberOfLines = _numberOfLines
    shadowColor = _shadowColor
    shadowOffset = _shadowOffset
    verticalMargin = _verticalMargin
  }
  
  // ---------------------------
  
  private static let _borderColor = GlyptodonColor.fromHexString("#666666")
  
  /// Color of the button border.
  public static var borderColor = _borderColor
  
  // ---------------------------
  
  private static let _borderMargin = CGSize(width: 5, height: 5)
  
  /// Margin between the button's title and its border.
  public static var borderMargin = _borderMargin
  
  // ---------------------------
  
  
  private static let _color = GlyptodonColor.fromHexString("#666666")
  
  /// Color of the button title.
  public static var color = _color
  
  
  // ---------------------------
  
  
  private static let defaultNonDynamicFontSize: CGFloat = 28
  
  private static let _font: UIFont = {
    if #available(iOS 8.2, *) {
      if #available(iOS 9.0, *) {
        // Use dynamic type font for accessibility when available
        return UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
      } else {
        return UIFont.systemFontOfSize(defaultNonDynamicFontSize, weight: UIFontWeightLight)
      }
    } else {
      return UIFont.systemFontOfSize(defaultNonDynamicFontSize)
    }
    }()
  
  /// Font of the button text.
  public static var font = _font
  
  // ---------------------------
  
  
  private static let _horizontalMargin: CGFloat = 15
  
  /// Horizontal margin between the button and the edge of the view.
  public static var horizontalMargin = _horizontalMargin
  
  
  // ---------------------------
  
  
  private static let _numberOfLines: Int = 5
  
  /// The maximum number of lines in the button title.
  public static var numberOfLines = _numberOfLines
  
  
  // ---------------------------
  
  
  private static let _shadowColor: UIColor? = nil
  
  /// Color of text shadow.
  public static var shadowColor = _shadowColor
  
  
  // ---------------------------
  
  
  private static let _shadowOffset = CGSize(width: 0, height: 1)
  
  /// Text shadow offset.
  public static var shadowOffset = _shadowOffset
  
  
  // ---------------------------
  
  
  private static let _verticalMargin: CGFloat = 20
  
  /// Vertical margin between the title and the button.
  public static var verticalMargin = _verticalMargin
  
  
  // ---------------------------
}
