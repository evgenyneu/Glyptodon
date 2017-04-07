import UIKit

/// Defines styles related to the title label.
open class GlyptodonTitleStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  open func clear() {
    _color = nil
    _font = nil
    _horizontalMargin = nil
    _numberOfLines = nil
    _shadowColor = nil
    _shadowOffset = nil
    _verticalOffset = nil
  }

  // -----------------------------
  
  fileprivate var _color: UIColor?
  
  /// Color of the title text.
  open var color: UIColor {
    get {
      return _color ??  GlyptodonTitleDefaultStyles.color
    }
    
    set {
      _color = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _font: UIFont?
  
  /// Color of the title text.
  open var font: UIFont {
    get {
      return _font ?? GlyptodonTitleDefaultStyles.font
    }
    
    set {
      _font = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _horizontalMargin: CGFloat?
  
  /// Horizontal margin between the title and the edge of the view.
  open var horizontalMargin: CGFloat {
    get {
      return _horizontalMargin ?? GlyptodonTitleDefaultStyles.horizontalMargin
    }
    
    set {
      _horizontalMargin = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _numberOfLines: Int?
  
  /// The maximum number of lines in the title.
  open var numberOfLines: Int {
    get {
      return _numberOfLines ?? GlyptodonTitleDefaultStyles.numberOfLines
    }
    
    set {
      _numberOfLines = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _shadowColor: UIColor?
  
  /// Color of text shadow.
  open var shadowColor: UIColor? {
    get {
      return _shadowColor ?? GlyptodonTitleDefaultStyles.shadowColor
    }
    
    set {
      _shadowColor = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _shadowOffset: CGSize?
  
  /// Text shadow offset.
  open var shadowOffset: CGSize {
    get {
      return _shadowOffset ?? GlyptodonTitleDefaultStyles.shadowOffset
    }
    
    set {
      _shadowOffset = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _verticalOffset: CGFloat?
  
  /// Vertical offset of the title relative to the center of the view. If zero the label is aligned exactly at the center.
  open var verticalOffset: CGFloat {
    get {
      return _verticalOffset ?? GlyptodonTitleDefaultStyles.verticalOffset
    }
    
    set {
      _verticalOffset = newValue
    }
  }
  
  // -----------------------------
}
