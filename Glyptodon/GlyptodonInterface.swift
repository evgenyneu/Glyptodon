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
  
  Shows the message view with a title.
  
  - parameter title: The text message to be shown.
  
  */
  func show(title: String)
  
  /**
  
  Shows the message view with a title and a button.
  
  - parameter title: The text message to be shown.
  - parameter withButton: The title for the button
  - parameter didTap: A closure that will be called when the button is tapped.

  */
  func show(title: String, withButton button: String, didTap: ()->())
  
  /// Hide the message window if it's currently open.
  func hide()
  
  /// Check if the message view is currently visible.
  var visible: Bool { get }
}
