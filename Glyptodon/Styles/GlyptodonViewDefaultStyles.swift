import UIKit

/**

Default styles for the view.
Default styles are used when individual element styles are not set.

*/
public struct GlyptodonViewDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    backgroundColor = _backgroundColor
  }
  
  private static let _backgroundColor: UIColor? = UIColor.blackColor()
  
  /// Background color of the view.
  public static var backgroundColor = _backgroundColor
}