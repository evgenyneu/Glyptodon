import UIKit

class GlyptodonView: UIView {
  func showInSuperview(superview: UIView, withMessage message: String) {
    superview.addSubview(self)
    addLayoutConstraints()
    createLabel(message)
    style()
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
  
  private func style() {
    backgroundColor = UIColor.grayColor()
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