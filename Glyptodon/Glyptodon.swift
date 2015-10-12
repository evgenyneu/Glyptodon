
import UIKit

/**

Glyptodon object is for showing and hiding of the message view.

The instance is created automatically in the `glyptodon` property of any UIView instance.
It is not expected to be instantiated manually anywhere except in unit tests.

For example:

    let view = UIView()
    view.glyptodon.show("No messages")

*/
final public class Glyptodon {
  private weak var superview: UIView!
  var didFinishShowAnimation: (()->())? // Called after the show animation is finished. Used in unit tests
  var didFinishHideAnimation: (()->())? // Called after hide animation is finished. Used in unit tests
    
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
    let currentExistingViews = existingViews
    
    let view = GlyptodonView(style: style)
    
    view.showInSuperview(superview, title: title, withAnimation: withAnimation,
      didFinishAnimation: { [weak self] in
        
        // Remove previously shown views after this view finished animating
        Glyptodon.removeViews(currentExistingViews)
        
        self?.didFinishShowAnimation?()
      }
    )
  }
  
  /**
  
  Shows the message view with a title and a button.
  
  - parameter title: The text message to be shown.
  - parameter withButton: The title for the button
  - parameter didTap: A closure that will be called when the button is tapped.
  
  */
  public func show(title: String, withButton button: String, withAnimation: Bool = true,
    didTap: ()->()) {
      
    let currentExistingViews = existingViews
    
    let view = GlyptodonView(style: style)
    
    view.showInSuperview(superview, title: title, withButton: button,
      withAnimation: withAnimation, didTapButton: didTap,
      didFinishAnimation: { [weak self] in
        
        // Remove previously shown views after this view finished animating
        Glyptodon.removeViews(currentExistingViews)
        
        self?.didFinishShowAnimation?()
      }
    )
  }
  
  /// Hide the message window if it's currently open.
  public func hide(withAnimation withAnimation: Bool = true) {
    let viewToHide = existingViews
    
    for (index, view) in viewToHide.enumerate() {
      let topView = index == viewToHide.count - 1
      let useAnimation = topView ? withAnimation : false // Animate only top view
      
      view.hide(withAnimation: useAnimation) { [weak self] in
        if topView {
          self?.didFinishHideAnimation?()
        }
      }
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
  
  /// Returns the currently displayed title label.
  public var titleLabel: UILabel? {
    get {
      return glyptodonView?.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
    }
  }
  
  /// Returns the button.
  public var button: UIButton? {
    get {
      return glyptodonView?.subviews.filter { $0 is UIButton }.map { $0 as! UIButton }.first
    }
  }
  
  private var glyptodonView: GlyptodonView? {
    get {
      return existingViews.last
    }
  }
  
  private var existingViews: [GlyptodonView] {
    return superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }
  }
  
  private class func removeViews(views: [UIView]) {
    for view in views {
      view.removeFromSuperview()
    }
  }
}