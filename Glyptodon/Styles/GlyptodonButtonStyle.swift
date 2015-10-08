import UIKit

/// Defines styles related to the button.
public class GlyptodonButtonStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  public func clear() {
    _borderColor = nil
    _borderMargin = nil
    _color = nil
    _font = nil
    _horizontalMargin = nil
    _numberOfLines = nil
    _shadowColor = nil
    _shadowOffset = nil
    _verticalMargin = nil
  }
  
  // -----------------------------
  
  private var _borderColor: UIColor?
  
  /// Color of the title text.
  public var borderColor: UIColor {
    get {
      return _borderColor ?? GlyptodonButtonDefaultStyles.borderColor
    }
    
    set {
      _borderColor = newValue
    }
  }
  
  // -----------------------------
  
  private var _borderMargin: CGSize?
  
  /// Color of the title text.
  public var borderMargin: CGSize {
    get {
      return _borderMargin ?? GlyptodonButtonDefaultStyles.borderMargin
    }
    
    set {
      _borderMargin = newValue
    }
  }
  
  // -----------------------------
  
  private var _color: UIColor?
  
  /// Color of the title text.
  public var color: UIColor {
    get {
      return _color ?? GlyptodonButtonDefaultStyles.color
    }
    
    set {
      _color = newValue
    }
  }
  
  // -----------------------------
  
  private var _font: UIFont?
  
  /// Color of the title text.
  public var font: UIFont {
    get {
      return _font ?? GlyptodonButtonDefaultStyles.font
    }
    
    set {
      _font = newValue
    }
  }
  
  // -----------------------------
  
  private var _horizontalMargin: CGFloat?
  
  /// Horizontal margin between the title and the edge of the view.
  public var horizontalMargin: CGFloat {
    get {
      return _horizontalMargin ?? GlyptodonButtonDefaultStyles.horizontalMargin
    }
    
    set {
      _horizontalMargin = newValue
    }
  }
  
  // -----------------------------
  
  private var _numberOfLines: Int?
  
  /// The maximum number of lines in the title.
  public var numberOfLines: Int {
    get {
      return _numberOfLines ?? GlyptodonButtonDefaultStyles.numberOfLines
    }
    
    set {
      _numberOfLines = newValue
    }
  }
  
  // -----------------------------
  
  private var _shadowColor: UIColor?
  
  /// Color of text shadow.
  public var shadowColor: UIColor? {
    get {
      return _shadowColor ?? GlyptodonButtonDefaultStyles.shadowColor
    }
    
    set {
      _shadowColor = newValue
    }
  }
  
  // -----------------------------
  
  private var _shadowOffset: CGSize?
  
  /// Text shadow offset.
  public var shadowOffset: CGSize {
    get {
      return _shadowOffset ?? GlyptodonButtonDefaultStyles.shadowOffset
    }
    
    set {
      _shadowOffset = newValue
    }
  }
  
  // -----------------------------
  
  private var _verticalMargin: CGFloat?
  
  /// Vertical offset of the title relative to the center of the view. If zero the label is aligned exactly at the center.
  public var verticalMargin: CGFloat {
    get {
      return _verticalMargin ?? GlyptodonButtonDefaultStyles.verticalMargin
    }
    
    set {
      _verticalMargin = newValue
    }
  }
  
  // -----------------------------
}