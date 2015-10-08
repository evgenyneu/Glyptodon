//
// Glyptodon
//
// A UI widget for displaying 'no results' message in iOS
//
// https://github.com/exchangegroup/glyptodon
//
// This file was automatically generated by combining multiple Swift source files.
//


// ----------------------------
//
// Glyptodon.swift
//
// ----------------------------


import UIKit

/**

Coordinates the process of showing and hiding of the message view.

The instance is created automatically in the `glyptodon` property of any UIView instance.
It is not expected to be instantiated manually anywhere except unit tests.

For example:

let view = UIView()
view.glyptodon.show("No messages")

*/
final class Glyptodon: GlyptodonInterface {
  private weak var superview: UIView!
  
  init(superview: UIView) {
    self.superview = superview
  }
  
  /// Defines styles for the view.
  var style = GlyptodonStyle()
  
  /**
  
  Shows the message view.
  
  - parameter message: The text message to be shown.
  
  */
  func show(message: String) {
    let view = GlyptodonView(style: style)
    view.showInSuperview(superview, withMessage: message)
  }
  
  /// Hide the message window if it's currently open.
  func hide() {
    
  }
}


// ----------------------------
//
// GlyptodonInterface.swift
//
// ----------------------------

import UIKit

/**

Coordinates the process of showing and hiding of the view.

The instance is created automatically in the `glyptodon` property of any UIView instance.
It is not expected to be instantiated manually anywhere except unit tests.

For example:

let view = UIView()
view.glyptodon.show("No messages")

*/
public protocol GlyptodonInterface: class {
  
  /// Defines styles for the view.
  var style: GlyptodonStyle { get set }

  /**
  
  Shows the message view.
  
  - parameter message: The text message to be shown.
  
  */
  func show(message: String)
  
  /// Hide the message window if it's currently open.
  func hide()
}


// ----------------------------
//
// GlyptodonView.swift
//
// ----------------------------

import UIKit

class GlyptodonView: UIView {
  var style: GlyptodonStyle
  
  convenience init(style: GlyptodonStyle) {
    self.init(frame: CGRect())
    
    self.style = style
  }
  
  override init(frame: CGRect) {
    style = GlyptodonStyle()
    
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func showInSuperview(superview: UIView, withMessage message: String) {
    superview.addSubview(self)
    addLayoutConstraints()
    createLabel(message)
    applyStyle()
  }
  
  private func createLabel(message: String) {
    let label = UILabel()
    label.text = message
    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    label.textColor = UIColor.redColor()
    label.textAlignment = .Center
    
    addSubview(label)
    addLabelLayoutConstraints(label)
  }
  
  private func applyStyle() {
    backgroundColor = style.view.backgroundColor 
  }
  
  private func addLayoutConstraints() {
    guard let superview = superview else { return }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: true)
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: false)
  }
  
  private func addLabelLayoutConstraints(label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    TegAutolayoutConstraints.fillParent(label, parentView: self, margin: 20, vertically: false)
    TegAutolayoutConstraints.centerY(label, viewTwo: self, constraintContainer: self)
  }
}


// ----------------------------
//
// GlyptodonStyle.swift
//
// ----------------------------

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


// ----------------------------
//
// GlyptodonViewDefaultStyles.swift
//
// ----------------------------

import UIKit

/**

Default styles for the view.
Default styles are used when individual element styles are not set.

*/
public struct GlyptodonViewDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    backgroundColor = _backgroundColor
  }
  
  // ---------------------------
  
  private static let _backgroundColor: UIColor? = GlyptodonColor.fromHexString("#EEEEEE")
  
  /// Background color of the view.
  public static var backgroundColor = _backgroundColor
  
  // ---------------------------
}


// ----------------------------
//
// GlyptodonViewStyle.swift
//
// ----------------------------

import UIKit

/// Defines styles related to the view in general.
public class GlyptodonViewStyle {
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
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


// ----------------------------
//
// UIView+Glyptodon.swift
//
// ----------------------------

import UIKit

private var sabAssociationKey: UInt8 = 0

/**

UIView extension for showing a 'no results' message.

let view = UIView()
view.glyptodon.show("Shopping cart is empty")

*/
public extension UIView {
  /**
  
  Message bar extension.
  Call `glyptodon.show`, `glyptodon.hide` functions to show a message widget in the view.
  
  let view = UIView()
  view.glyptodon.show("Shopping cart is empty")
  
  */
  public var glyptodon: GlyptodonInterface {
    get {
      if let value = objc_getAssociatedObject(self, &sabAssociationKey) as? GlyptodonInterface {
        return value
      } else {
        let glyptodon = Glyptodon(superview: self)
        
        objc_setAssociatedObject(self, &sabAssociationKey, glyptodon,
          objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return glyptodon
      }
    }
    
    set {
      objc_setAssociatedObject(self, &sabAssociationKey, newValue,
        objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
  }
}


// ----------------------------
//
// GlyptodonColor.swift
//
// ----------------------------

import UIKit

/**
  
Creates a UIColor object from a string.

Examples:

    GlyptodonColor.fromHexString('#340f9a')

    // With alpha channel
    GlyptodonColor.fromHexString('#f1a2b3a6')

*/
public class GlyptodonColor {
  /**
  
  Creates a UIColor object from a string.
  
  - parameter rgba: a RGB/RGBA string representation of color. It can include optional alpha value. Example: "#cca213" or "#cca21312" (with alpha value).
  
  - returns: UIColor object.
  
  */
  public class func fromHexString(rgba: String) -> UIColor {
    var red: CGFloat   = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat  = 0.0
    var alpha: CGFloat = 1.0
    
    if !rgba.hasPrefix("#") {
      print("Warning: GlyptodonColor.fromHexString, # character missing")
      return UIColor()
    }
    
    let index = rgba.startIndex.advancedBy(1)
    let hex = rgba.substringFromIndex(index)
    let scanner = NSScanner(string: hex)
    var hexValue: CUnsignedLongLong = 0
    
    if !scanner.scanHexLongLong(&hexValue) {
      print("Warning: GlyptodonColor.fromHexString, error scanning hex value")
      return UIColor()
    }

    if hex.characters.count == 6 {
      red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
      green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
      blue  = CGFloat(hexValue & 0x0000FF) / 255.0
    } else if hex.characters.count == 8 {
      red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
      green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
      blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
      alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
    } else {
      print("Warning: GlyptodonColor.fromHexString, invalid rgb string, length should be 7 or 9")
      return UIColor()
    }
   
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }
}


// ----------------------------
//
// TegAutolayoutConstraints.swift
//
// ----------------------------

//
//  TegAlign.swift
//
//  Collection of shortcuts to create autolayout constraints.
//

import UIKit

class TegAutolayoutConstraints {
  class func centerX(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: false)
  }
  
  class func centerY(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {
      
      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: true)
  }
  
  private class func center(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, vertically: Bool = false) -> [NSLayoutConstraint] {
      
      let attribute = vertically ? NSLayoutAttribute.CenterY : NSLayoutAttribute.CenterX
      
      let constraint = NSLayoutConstraint(
        item: viewOne,
        attribute: attribute,
        relatedBy: NSLayoutRelation.Equal,
        toItem: viewTwo,
        attribute: attribute,
        multiplier: 1,
        constant: 0)
      
      constraintContainer.addConstraint(constraint)
      
      return [constraint]
  }
  
  class func fillParent(view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool) {
    var marginFormat = ""
    
    if margin != 0 {
      marginFormat = "-\(margin)-"
    }
    
    var format = "|\(marginFormat)[view]\(marginFormat)|"
    
    if vertically {
      format = "V:" + format
    }
    
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: [], metrics: nil,
      views: ["view": view])
    
    parentView.addConstraints(constraints)
  }
}


