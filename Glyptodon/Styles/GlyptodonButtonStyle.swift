import UIKit

/// Defines styles related to the button.
open class GlyptodonButtonStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  open func clear() {
    _color = nil
    _colorHighlighted = nil
    _font = nil
    _horizontalMargin = nil
    _numberOfLines = nil
    _shadowColor = nil
    _shadowOffset = nil
    _verticalMargin = nil
  }
  
  // -----------------------------
  
  fileprivate var _color: UIColor?
  
  /// Color of the button title.
  open var color: UIColor {
    get {
      return _color ?? GlyptodonButtonDefaultStyles.color
    }
    
    set {
      _color = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _colorHighlighted: UIColor?
  
  /// Color of the button title when it's tapped.
  open var colorHighlighted: UIColor {
    get {
      return _colorHighlighted ?? GlyptodonButtonDefaultStyles.colorHighlighted
    }
    
    set {
      _colorHighlighted = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _font: UIFont?
  
  /// Font of the button title.
  open var font: UIFont {
    get {
      return _font ?? GlyptodonButtonDefaultStyles.font
    }
    
    set {
      _font = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _horizontalMargin: CGFloat?
  
  /// Horizontal margin between the button and the edge of the view.
  open var horizontalMargin: CGFloat {
    get {
      return _horizontalMargin ?? GlyptodonButtonDefaultStyles.horizontalMargin
    }
    
    set {
      _horizontalMargin = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _numberOfLines: Int?
  
  /// The maximum number of lines in the button title.
  open var numberOfLines: Int {
    get {
      return _numberOfLines ?? GlyptodonButtonDefaultStyles.numberOfLines
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
      return _shadowColor ?? GlyptodonButtonDefaultStyles.shadowColor
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
      return _shadowOffset ?? GlyptodonButtonDefaultStyles.shadowOffset
    }
    
    set {
      _shadowOffset = newValue
    }
  }
  
  // -----------------------------
  
  fileprivate var _verticalMargin: CGFloat?
  
  /// Vertical margin between the title and the button.
  open var verticalMargin: CGFloat {
    get {
      return _verticalMargin ?? GlyptodonButtonDefaultStyles.verticalMargin
    }
    
    set {
      _verticalMargin = newValue
    }
  }
  
  // -----------------------------
}
