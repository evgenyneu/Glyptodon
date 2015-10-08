import UIKit

/// Combines various styles for the toolbar element.
public class GlyptodonStyle {
  /**
  
  Reverts all the default styles to their initial values. Usually used in setUp() function in the unit tests.
  
  */
  public static func resetDefaultStyles() {
    GlyptodonViewDefaultStyles.resetToDefaults()
  }
  
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  public func clear() {
    view.clear()
  }
  
  /**

  Styles for the  view.

  */
  public lazy var view = GlyptodonViewStyle()
}