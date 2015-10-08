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
    verticalOffset = _verticalOffset
    numberOfLines = _numberOfLines
    shadowColor = _shadowColor
    shadowOffset = _shadowOffset
  }
  
  // ---------------------------
  
  
  private static let _color = GlyptodonColor.fromHexString("#666666")
  
  /// Color of the label text.
  public static var color = _color
  
  
  // ---------------------------
  
  
  private static let _font: UIFont = {
    if #available(iOS 8.2, *) {
      return UIFont.systemFontOfSize(30, weight: UIFontWeightLight)
    } else {
      return UIFont.systemFontOfSize(30)
    }
  }()
  
  /// Font of the label text.
  public static var font = _font
  
  
  // ---------------------------
  
  
  private static let _numberOfLines: Int = 3
  
  /// The maximum number of lines in the label.
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
  
  
  private static let _verticalOffset: CGFloat = 10
  
  /// Vertical offset of the label relative to the center of the view. If zero the label is aligned exactly at the center.
  public static var verticalOffset = _verticalOffset
  
  
  // ---------------------------
}
