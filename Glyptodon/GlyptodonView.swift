import UIKit

class GlyptodonView: UIView {
  var style: GlyptodonStyle
  
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
  
  func showInSuperview(superview: UIView, withMessage message: String) {
    superview.addSubview(self)
    addLayoutConstraints()
    createLabel(message)
    applyStyle()
  }
  
  
  private func applyStyle() {
    backgroundColor = style.view.backgroundColor
  }
  
  private func addLayoutConstraints() {
    guard let superview = superview else { return }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: true)
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: false)
  }
  
  // MARK: - Label
  
  private func createLabel(message: String) {
    let label = UILabel()
    label.text = message
    
    addSubview(label)
    addLabelLayoutConstraints(label)
    applyLabelStyle(label)
  }
  
  private func addLabelLayoutConstraints(label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    TegAutolayoutConstraints.fillParent(label, parentView: self, margin: 20, vertically: false)
    TegAutolayoutConstraints.centerY(label, viewTwo: self, constraintContainer: self)
  }
  
  private func applyLabelStyle(label: UILabel) {
    label.textAlignment = .Center
    
    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    label.textColor = UIColor.redColor()
  }
}