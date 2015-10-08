import UIKit

class GlyptodonView: UIView {
  func showInSuperview(superview: UIView, withMessage message: String) {
    superview.addSubview(self)
  }
}