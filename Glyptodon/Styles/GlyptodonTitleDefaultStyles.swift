import UIKit

/**

Default styles for the title label.
Default styles are used when individual element styles are not set.

*/
public struct GlyptodonTitleDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    color = _color
    font = _font
    horizontalMargin = _horizontalMargin
    verticalOffset = _verticalOffset
    numberOfLines = _numberOfLines
    shadowColor = _shadowColor
    shadowOffset = _shadowOffset
  }
  
  // ---------------------------
  
  
  fileprivate static let _color = GlyptodonColor.fromHexString("#666666")
  
  /// Color of the title text.
  public static var color = _color
  
  
  // ---------------------------
  
  fileprivate static let defaultNonDynamicFontSize: CGFloat = 28
  
  fileprivate static let _font: UIFont = {
    if #available(iOS 8.2, *) {
      if #available(iOS 9.0, *) {
        // Use dynamic type font for accessibility when available
        return UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
      } else {
        return UIFont.systemFont(ofSize: defaultNonDynamicFontSize, weight: UIFontWeightLight)
      }
    } else {
      return UIFont.systemFont(ofSize: defaultNonDynamicFontSize)
    }
  }()
  
  /// Font of the title text.
  public static var font = _font
  
  // ---------------------------
  
  
  fileprivate static let _horizontalMargin: CGFloat = 15
  
  /// Horizontal margin between the title and the edge of the view.
  public static var horizontalMargin = _horizontalMargin
  
  
  // ---------------------------
  
  
  fileprivate static let _numberOfLines: Int = 5
  
  /// The maximum number of lines in the title.
  public static var numberOfLines = _numberOfLines
  
  
  // ---------------------------
  
  
  fileprivate static let _shadowColor: UIColor? = nil
  
  /// Color of text shadow.
  public static var shadowColor = _shadowColor
  

  // ---------------------------

  
  fileprivate static let _shadowOffset = CGSize(width: 0, height: 1)
  
  /// Text shadow offset.
  public static var shadowOffset = _shadowOffset
  
  
  // ---------------------------
  
  
  fileprivate static let _verticalOffset: CGFloat = 0
  
  /// Vertical offset of the title relative to the center of the view. If zero the label is aligned exactly at the center.
  public static var verticalOffset = _verticalOffset
  
  
  // ---------------------------
}
