
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
  
  /**
  
  Shows the message view.
  
  - parameter message: The text message to be shown.
  
  */
  func show(message: String) {
   
  }
  
  /// Hide the message window if it's currently open.
  func hide() {
    
  }
}