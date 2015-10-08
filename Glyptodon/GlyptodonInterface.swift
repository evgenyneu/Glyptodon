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
  /**
  
  Shows the message view.
  
  - parameter message: The text message to be shown.
  
  */
  func show(message: String)
  
  /// Hide the message window if it's currently open.
  func hide()
}
