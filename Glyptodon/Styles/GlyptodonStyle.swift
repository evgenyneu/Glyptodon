import UIKit

/// Combines various styles for the toolbar element.
open class GlyptodonStyle {
  /**
  
  Reverts all the default styles to their initial values. Usually used in setUp() function in the unit tests.
  
  */
  open static func resetDefaultStyles() {
    GlyptodonViewDefaultStyles.resetToDefaults()
    GlyptodonTitleDefaultStyles.resetToDefaults()
  }
  
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  open func clear() {
    view.clear()
  }
  
  /**

  Styles for the  view.

  */
  open lazy var view = GlyptodonViewStyle()
  
  /**
  
  Styles for the title text.
  
  */
  open lazy var title = GlyptodonTitleStyle()
  
  /**
  
  Styles for the button.
  
  */
  open lazy var button = GlyptodonButtonStyle()
}
