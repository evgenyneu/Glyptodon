import UIKit

/// Defines styles related to the title label.
public class GlyptodonTitleStyle {
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  public func clear() {
    _color = nil
    _font = nil
    _numberOfLines = nil
    _shadowColor = nil
    _shadowOffset = nil
    _verticalOffset = nil
  }

  // -----------------------------
  
  private var _color: UIColor?
  
  /// Color of the label text.
  public var color: UIColor {
    get {
      return _color ??  GlyptodonTitleDefaultStyles.color
    }
    
    set {
      _color = newValue
    }
  }
  
  // -----------------------------
  
  private var _font: UIFont?
  
  /// Color of the label text.
  public var font: UIFont {
    get {
      return _font ?? GlyptodonTitleDefaultStyles.font
    }
    
    set {
      _font = newValue
    }
  }
  
  // -----------------------------
  
  private var _numberOfLines: Int?
  
  /// The maximum number of lines in the label.
  public var numberOfLines: Int {
    get {
      return _numberOfLines ?? GlyptodonTitleDefaultStyles.numberOfLines
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
      return _shadowColor ?? GlyptodonTitleDefaultStyles.shadowColor
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
      return _shadowOffset ?? GlyptodonTitleDefaultStyles.shadowOffset
    }
    
    set {
      _shadowOffset = newValue
    }
  }
  
  // -----------------------------
  
  private var _verticalOffset: CGFloat?
  
  /// Vertical offset of the label relative to the center of the view. If zero the label is aligned exactly at the center.
  public var verticalOffset: CGFloat {
    get {
      return _verticalOffset ?? GlyptodonTitleDefaultStyles.verticalOffset
    }
    
    set {
      _verticalOffset = newValue
    }
  }
  
  // -----------------------------
}