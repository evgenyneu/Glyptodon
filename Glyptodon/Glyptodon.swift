
import UIKit

/**

Glyptodon object is for showing and hiding of the message view.

The instance is created automatically in the `glyptodon` property of any UIView instance.
It is not expected to be instantiated manually anywhere except unit tests.

For example:

let view = UIView()
view.glyptodon.show("No messages")

*/
final public class Glyptodon {
  private weak var superview: UIView!
  var didHide: (()->())? // Used in unit tests
  
  /// Specify optional layout guide for positioning the view.
  var topLayoutGuide: UILayoutSupport?
  
  /// Specify optional layout guide for positioning the view.
  var bottomLayoutGuide: UILayoutSupport?
    
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
    let view = GlyptodonView(style: style,
      topLayoutGuide: topLayoutGuide, bottomLayoutGuide: bottomLayoutGuide)
    
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
    let view = GlyptodonView(style: style, topLayoutGuide: topLayoutGuide,
      bottomLayoutGuide: bottomLayoutGuide)
    
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