import UIKit

/**

Default styles for the view.
Default styles are used when individual element styles are not set.

*/
public struct GlyptodonViewDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    animationDurationSeconds = _animationDurationSeconds
    backgroundColor = _backgroundColor
  }
  
  // ---------------------------
  
  fileprivate static let _animationDurationSeconds: TimeInterval = 0.3
  
  /// Duration of the fade animation that is used to show and hide the message view. Setting it to 0 will result in no animation.
  public static var animationDurationSeconds = _animationDurationSeconds
  
  // ---------------------------
  
  fileprivate static let _backgroundColor: UIColor? = GlyptodonColor.fromHexString("#EEEEEE")
  
  /// Background color of the message view.
  public static var backgroundColor = _backgroundColor
  
  // ---------------------------

}
