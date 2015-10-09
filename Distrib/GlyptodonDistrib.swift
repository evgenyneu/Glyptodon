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
final public class Glyptodon {
  private weak var superview: UIView!
  var didHide: (()->())? // Used in unit tests
    
  init(superview: UIView) {
    self.superview = superview
  }
  
  /// Defines styles for the view.
  public var style = GlyptodonStyle()
  
  /**
  
  Shows the message view with a title.
  
  - parameter title: The text message to be shown.
  
  */
  public func show(title: String, withAnimation: Bool = true) {
    removeExistingViews()
    let view = GlyptodonView(style: style)
    view.showInSuperview(superview, title: title, withAnimation: withAnimation)
  }
  
  /**
  
  Shows the message view with a title and a button.
  
  - parameter title: The text message to be shown.
  - parameter withButton: The title for the button
  - parameter didTap: A closure that will be called when the button is tapped.
  
  */
  public func show(title: String, withButton button: String, withAnimation: Bool = true, didTap: ()->()) {
    removeExistingViews()
    let view = GlyptodonView(style: style)
    
    view.showInSuperview(superview, title: title, withButton: button, withAnimation: withAnimation, didTapButton: didTap)
  }
  
  /// Hide the message window if it's currently open.
  public func hide(withAnimation withAnimation: Bool = true) {
    glyptodonView?.hide(withAnimation: withAnimation) { [weak self] in
      self?.didHide?()
    }
  }
  
  /// Check if the message view is currently visible.
  public var visible: Bool {
    get {
      if let glyptodonView = glyptodonView {
        return !glyptodonView.beingHidden
      }
      
      return false
    }
  }
  
  private var glyptodonView: GlyptodonView? {
    get {
      return superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }.first
    }
  }
  
  private func removeExistingViews() {
    for view in superview.subviews {
      if let existingView = view as? GlyptodonView {
        existingView.removeFromSuperview()
      }
    }
  }
  
}


// ----------------------------
//
// GlyptodonView.swift
//
// ----------------------------

import UIKit

class GlyptodonView: UIView {
  var style: GlyptodonStyle
  
  /// Shows if the view is being hidden
  var beingHidden = false
  
  /// Button tap closure supplied by the user
  var didTapButtonHandler: (()->())?
  
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
  
  func showInSuperview(superview: UIView, title: String, withAnimation: Bool) {
    superview.addSubview(self)
    addLayoutConstraints()
    createTitle(title)
    applyStyle()
    
    if withAnimation {
      animateIn()
    }
  }
  
  func showInSuperview(superview: UIView, title: String,
    withButton buttonTitle: String, withAnimation: Bool, didTapButton: ()->()) {
    
    showInSuperview(superview, title: title, withAnimation: withAnimation)
      
    self.didTapButtonHandler = didTapButton
    createButton(buttonTitle)
  }
  
  func hide(withAnimation withAnimation: Bool, didFinish: ()->()) {
    if beingHidden {
      didFinish()
      return
    }
    
    beingHidden = true
    
    if withAnimation {
      animateOut() { [weak self] in
        self?.removeFromSuperview()
        didFinish()
      }
    } else {
      removeFromSuperview()
      didFinish()
    }
  }
  
  private func applyStyle() {
    backgroundColor = style.view.backgroundColor
  }
  
  private func addLayoutConstraints() {
    guard let superview = superview else { return }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    // Fill the message view to covert entire area of its superview
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: true)
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: false)
  }
  
  private var titleLabel: UILabel? {
    return subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
  }
  
  // MARK: - Title
  
  private func createTitle(title: String) {
    let label = UILabel()
    addSubview(label)
    label.text = title
    
    addTitleLayoutConstraints(label)
    applyTitleStyle(label)
  }
  
  private func addTitleLayoutConstraints(label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    
    
    // Make the width of the title label the same as the view, minus the margins.
    TegAutolayoutConstraints.fillParent(label, parentView: self,
      margin: style.title.horizontalMargin, vertically: false)
    
    // Center the label vertically in the view with an offset.
    TegAutolayoutConstraints.centerY(label, viewTwo: self, constraintContainer: self,
      constant: style.title.verticalOffset)
  }
  
  private func applyTitleStyle(label: UILabel) {
    label.textAlignment = .Center
    label.font = style.title.font
    label.textColor = style.title.color
    label.numberOfLines = style.title.numberOfLines
    label.shadowColor = style.title.shadowColor
    label.shadowOffset = style.title.shadowOffset
  }
  
  // MARK: - Button
  
  private func createButton(title: String) {
    let button = UIButton()
    addSubview(button)
    button.setTitle(title, forState: .Normal)
    addButtonLayoutConstraints(button)
    applyButtonStyle(button)
    setupTapHandler(button)
  }
  
  private func addButtonLayoutConstraints(button: UIButton) {
    guard let titleLabel = titleLabel else { return }
    button.translatesAutoresizingMaskIntoConstraints = false
    
    // Make the width of the button the same as the view, minus the margins.
    TegAutolayoutConstraints.fillParent(button, parentView: self, margin: style.title.horizontalMargin, vertically: false)
    
    // Position the button under the title label
    TegAutolayoutConstraints.twoViewsNextToEachOther(titleLabel, viewTwo: button, constraintContainer: self, margin: 20, vertically: true)
  }
  
  private func applyButtonStyle(button: UIButton) {
    button.setTitleColor(style.button.color, forState: .Normal)
    button.setTitleColor(style.button.colorHighlighted, forState: .Highlighted)
    
    button.setTitleShadowColor(style.button.shadowColor, forState: .Normal)
    
    guard let label = button.titleLabel else { return }
    
    label.font = style.button.font
    label.numberOfLines = style.button.numberOfLines
    label.shadowOffset = style.button.shadowOffset
  }
  
  private func setupTapHandler(button: UIButton) {
    button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
  }
  
  func didTapButton(button: UIButton) {
    didTapButtonHandler?()
  }
  
  // MARK: - Animation
  
  private func animateIn() {
    alpha = 0
    
    UIView.animateWithDuration(style.view.animationDurationSeconds) { [weak self] in
      self?.alpha = 1
    }
  }
  
  private func animateOut(didFinish: ()->()) {
    UIView.animateWithDuration(style.view.animationDurationSeconds,
      animations: { [weak self] in
        self?.alpha = 0
      },
      completion: { _ in
        didFinish()
      }
    )
  }
}


// ----------------------------
//
// GlyptodonButtonDefaultStyles.swift
//
// ----------------------------


import UIKit

/**

Default styles for the button.
Default styles are used when individual element styles are not set.

*/
public struct GlyptodonButtonDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    color = _color
    colorHighlighted = _colorHighlighted
    font = _font
    horizontalMargin = _horizontalMargin
    numberOfLines = _numberOfLines
    shadowColor = _shadowColor
    shadowOffset = _shadowOffset
    verticalMargin = _verticalMargin
  }
  
  // ---------------------------
  

  private static let _color: UIColor = GlyptodonColor.fromHexString("#007AFF")
  
  /// Color of the button title.
  public static var color = _color
  
  
  // ---------------------------
  
  
  private static let _colorHighlighted: UIColor = GlyptodonColor.fromHexString("#007AFF33")
  
  /// Color of the button title when it's tapped.
  public static var colorHighlighted = _colorHighlighted
  
  
  // ---------------------------
  
  
  private static let _font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
  
  /// Font of the button title.
  public static var font = _font
  
  // ---------------------------
  
  
  private static let _horizontalMargin: CGFloat = 15
  
  /// Horizontal margin between the button and the edge of the view.
  public static var horizontalMargin = _horizontalMargin
  
  
  // ---------------------------
  
  
  private static let _numberOfLines: Int = 5
  
  /// The maximum number of lines in the button title.
  public static var numberOfLines = _numberOfLines
  
  
  // ---------------------------
  
  
  private static let _shadowColor: UIColor? = nil
  
  /// Color of text shadow.
  public static var shadowColor = _shadowColor
  
  
  // ---------------------------
  
  
  private static let _shadowOffset = CGSize(width: 0, height: 1)
  
  /// Text shadow offset.
  public static var shadowOffset = _shadowOffset
  
  
  // ---------------------------
  
  
  private static let _verticalMargin: CGFloat = 20
  
  /// Vertical margin between the title and the button.
  public static var verticalMargin = _verticalMargin
  
  
  // ---------------------------
}


// ----------------------------
//
// GlyptodonButtonStyle.swift
//
// ----------------------------

import UIKit

/// Defines styles related to the button.
public class GlyptodonButtonStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  public func clear() {
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
  
  private var _color: UIColor?
  
  /// Color of the button title.
  public var color: UIColor {
    get {
      return _color ?? GlyptodonButtonDefaultStyles.color
    }
    
    set {
      _color = newValue
    }
  }
  
  // -----------------------------
  
  private var _colorHighlighted: UIColor?
  
  /// Color of the button title when it's tapped.
  public var colorHighlighted: UIColor {
    get {
      return _colorHighlighted ?? GlyptodonButtonDefaultStyles.colorHighlighted
    }
    
    set {
      _colorHighlighted = newValue
    }
  }
  
  // -----------------------------
  
  private var _font: UIFont?
  
  /// Font of the button title.
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
  
  /// Horizontal margin between the button and the edge of the view.
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
  
  /// The maximum number of lines in the button title.
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
  
  /// Vertical margin between the title and the button.
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
    GlyptodonTitleDefaultStyles.resetToDefaults()
  }
  
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  public func clear() {
    view.clear()
  }
  
  /**

  Styles for the  view.

  */
  public lazy var view = GlyptodonViewStyle()
  
  /**
  
  Styles for the title text.
  
  */
  public lazy var title = GlyptodonTitleStyle()
  
  /**
  
  Styles for the button.
  
  */
  public lazy var button = GlyptodonButtonStyle()
}


// ----------------------------
//
// GlyptodonTitleDefaultStyles.swift
//
// ----------------------------

import UIKit

/**

Default styles for the title label.
Default styles are used when individual element styles are not set.

*/
public struct GlyptodonTitleDefaultStyles {
  
  /// Revert the property values to their defaults
  public static func resetToDefaults() {
    color = _color
    font = _font
    horizontalMargin = _horizontalMargin
    verticalOffset = _verticalOffset
    numberOfLines = _numberOfLines
    shadowColor = _shadowColor
    shadowOffset = _shadowOffset
  }
  
  // ---------------------------
  
  
  private static let _color = GlyptodonColor.fromHexString("#666666")
  
  /// Color of the title text.
  public static var color = _color
  
  
  // ---------------------------
  
  
  private static let defaultNonDynamicFontSize: CGFloat = 28
  
  private static let _font: UIFont = {
    if #available(iOS 8.2, *) {
      if #available(iOS 9.0, *) {
        // Use dynamic type font for accessibility when available
        return UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
      } else {
        return UIFont.systemFontOfSize(defaultNonDynamicFontSize, weight: UIFontWeightLight)
      }
    } else {
      return UIFont.systemFontOfSize(defaultNonDynamicFontSize)
    }
  }()
  
  /// Font of the title text.
  public static var font = _font
  
  // ---------------------------
  
  
  private static let _horizontalMargin: CGFloat = 15
  
  /// Horizontal margin between the title and the edge of the view.
  public static var horizontalMargin = _horizontalMargin
  
  
  // ---------------------------
  
  
  private static let _numberOfLines: Int = 5
  
  /// The maximum number of lines in the title.
  public static var numberOfLines = _numberOfLines
  
  
  // ---------------------------
  
  
  private static let _shadowColor: UIColor? = nil
  
  /// Color of text shadow.
  public static var shadowColor = _shadowColor
  

  // ---------------------------

  
  private static let _shadowOffset = CGSize(width: 0, height: 1)
  
  /// Text shadow offset.
  public static var shadowOffset = _shadowOffset
  
  
  // ---------------------------
  
  
  private static let _verticalOffset: CGFloat = 0
  
  /// Vertical offset of the title relative to the center of the view. If zero the label is aligned exactly at the center.
  public static var verticalOffset = _verticalOffset
  
  
  // ---------------------------
}


// ----------------------------
//
// GlyptodonTitleStyle.swift
//
// ----------------------------

import UIKit

/// Defines styles related to the title label.
public class GlyptodonTitleStyle {
  
  /// Clears the styles for all properties for this style object. Default styles will be used instead.
  public func clear() {
    _color = nil
    _font = nil
    _horizontalMargin = nil
    _numberOfLines = nil
    _shadowColor = nil
    _shadowOffset = nil
    _verticalOffset = nil
  }

  // -----------------------------
  
  private var _color: UIColor?
  
  /// Color of the title text.
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
  
  /// Color of the title text.
  public var font: UIFont {
    get {
      return _font ?? GlyptodonTitleDefaultStyles.font
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
      return _horizontalMargin ?? GlyptodonTitleDefaultStyles.horizontalMargin
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
  
  /// Vertical offset of the title relative to the center of the view. If zero the label is aligned exactly at the center.
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
    animationDurationSeconds = _animationDurationSeconds
    backgroundColor = _backgroundColor
  }
  
  // ---------------------------
  
  private static let _backgroundColor: UIColor? = GlyptodonColor.fromHexString("#EEEEEE")
  
  /// Background color of the view.
  public static var backgroundColor = _backgroundColor
  
  // ---------------------------
  
  private static let _animationDurationSeconds: NSTimeInterval = 0.3
  
  /// Duration of the fade animation that is used to show the message view. Setting it to 0 will result in no animation.
  public static var animationDurationSeconds = _animationDurationSeconds
  
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
  
  // ---------------------------
  
  private var _animationDurationSeconds: NSTimeInterval?
  
  /// Duration of the fade animation that is used to show the message view. Setting it to 0 will result in no animation.
  public var animationDurationSeconds: NSTimeInterval {
    get {
      return _animationDurationSeconds ?? GlyptodonViewDefaultStyles.animationDurationSeconds
    }
    
    set {
      _animationDurationSeconds = newValue
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
  public var glyptodon: Glyptodon {
    get {
      if let value = objc_getAssociatedObject(self, &sabAssociationKey) as? Glyptodon {
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
    constraintContainer: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer,
      vertically: false, constant: constant)
  }
  
  class func centerY(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer,
      vertically: true, constant: constant)
  }
  
  private class func center(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, vertically: Bool = false, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    let attribute = vertically ? NSLayoutAttribute.CenterY : NSLayoutAttribute.CenterX
    
    let constraint = NSLayoutConstraint(
      item: viewOne,
      attribute: attribute,
      relatedBy: NSLayoutRelation.Equal,
      toItem: viewTwo,
      attribute: attribute,
      multiplier: 1,
      constant: constant)
    
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
  
  class func twoViewsNextToEachOther(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
      var marginFormat = ""
      
      if margin != 0 {
        marginFormat = "-\(margin)-"
      }
      
      var format = "[viewOne]\(marginFormat)[viewTwo]"
      
      if vertically {
        format = "V:" + format
      }
      
      let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
        options: [], metrics: nil,
        views: [ "viewOne": viewOne, "viewTwo": viewTwo ])
      
      constraintContainer.addConstraints(constraints)
      
      return constraints
  }
}


