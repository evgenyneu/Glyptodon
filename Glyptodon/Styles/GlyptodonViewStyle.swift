import UIKit

/// Defines styles related to the view in general.
public class GlyptodonViewStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  public func clear() {
    _backgroundColor = nil
  }
  
  // ---------------------------
  
  
  private var _animationDurationSeconds: NSTimeInterval?
  
  /// Duration of the fade animation that is used to show and hide the message view. Setting it to 0 will result in no animation.
  public var animationDurationSeconds: NSTimeInterval {
    get {
      return _animationDurationSeconds ?? GlyptodonViewDefaultStyles.animationDurationSeconds
    }
    
    set {
      _animationDurationSeconds = newValue
    }
  }
  
  // -----------------------------
  
  private var _backgroundColor: UIColor?
  
  /// Background color of the message view.
  public var backgroundColor: UIColor? {
    get {
      return _backgroundColor ?? GlyptodonViewDefaultStyles.backgroundColor
    }
    
    set {
      _backgroundColor = newValue
    }
  }
  
  // ---------------------------
}