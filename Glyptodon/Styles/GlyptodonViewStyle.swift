import UIKit

/// Defines styles related to the view in general.
open class GlyptodonViewStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  open func clear() {
    _backgroundColor = nil
  }
  
  // ---------------------------
  
  
  fileprivate var _animationDurationSeconds: TimeInterval?
  
  /// Duration of the fade animation that is used to show and hide the message view. Setting it to 0 will result in no animation.
  open var animationDurationSeconds: TimeInterval {
    get {
      return _animationDurationSeconds ?? GlyptodonViewDefaultStyles.animationDurationSeconds
    }
    
    set {
      _animationDurationSeconds = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _backgroundColor: UIColor?
  
  /// Background color of the message view.
  open var backgroundColor: UIColor? {
    get {
      return _backgroundColor ?? GlyptodonViewDefaultStyles.backgroundColor
    }
    
    set {
      _backgroundColor = newValue
    }
  }
  
  // ---------------------------
}
