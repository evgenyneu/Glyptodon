import UIKit

/// Defines styles related to the view in general.
public class GlyptodonViewStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  public func clear() {
    _backgroundColor = nil
  }
  
  // ---------------------------
  
  private var _backgroundColor: UIColor?
  
  /// Background color of the bar.
  public var backgroundColor: UIColor? {
    get {
      return _backgroundColor ?? GlyptodonViewDefaultStyles.backgroundColor
    }
    
    set {
      _backgroundColor = newValue
    }
  }
  
  // -----------------------------
}