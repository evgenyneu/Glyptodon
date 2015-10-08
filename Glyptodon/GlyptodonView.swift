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
  
  func showInSuperview(superview: UIView, withTitle title: String) {
    superview.addSubview(self)
    addLayoutConstraints()
    createTitle(title)
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
  
  // MARK: - Title
  
  private func createTitle(title: String) {
    let label = UILabel()
    label.text = title
    
    addSubview(label)
    addTitleLayoutConstraints(label)
    applyTitleStyle(label)
  }
  
  private func addTitleLayoutConstraints(label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    TegAutolayoutConstraints.fillParent(label, parentView: self,
      margin: style.title.horizontalMargin, vertically: false)
    
    TegAutolayoutConstraints.centerY(label, viewTwo: self, constraintContainer: self,
      constant: style.title.verticalOffset)
  }
  
  private func applyTitleStyle(label: UILabel) {
    label.textAlignment = .Center
    label.font = style.title.font
    label.textColor = style.title.color
    label.numberOfLines = style.title.numberOfLines
    label.shadowColor = style.title.shadowColor
    label.shadowOffset = style.title.shadowOffset
  }
}