
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
  
  Shows the message view with a title.
  
  - parameter title: The text message to be shown.
  
  */
  func show(title: String) {
    removeExistingViews()
    let view = GlyptodonView(style: style)
    view.showInSuperview(superview, title: title)
  }
  
  /**
  
  Shows the message view with a title and a button.
  
  - parameter title: The text message to be shown.
  - parameter withButton: The title for the button
  - parameter didTap: A closure that will be called when the button is tapped.
  
  */
  func show(title: String, withButton button: String, didTap: ()->()) {
    removeExistingViews()
    let view = GlyptodonView(style: style)
    
    view.showInSuperview(superview, title: title, withButton: button, didTapButton: didTap)
  }
  
  /// Hide the message window if it's currently open.
  func hide() {
    glyptodonView?.hide()
  }
  
  /// Check if the message view is currently visible.
  var visible: Bool {
    get {
      return glyptodonView != nil
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