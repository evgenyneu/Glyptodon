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