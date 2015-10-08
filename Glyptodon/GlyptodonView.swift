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
  
  func showInSuperview(superview: UIView, title: String) {
    superview.addSubview(self)
    addLayoutConstraints()
    createTitle(title)
    applyStyle()
  }
  
  func showInSuperview(superview: UIView, title: String,
    withButton buttonTitle: String, didTapButton: ()->()) {
    
    showInSuperview(superview, title: title)
      
    createButton(buttonTitle)
  }
  
  func hide() {
    removeFromSuperview()
  }
  
  private func applyStyle() {
    backgroundColor = style.view.backgroundColor
  }
  
  private func addLayoutConstraints() {
    guard let superview = superview else { return }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    // Fill the message view to covert entire area of its superview
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: true)
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: false)
  }
  
  private var titleLabel: UILabel? {
    return subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
  }
  
  // MARK: - Title
  
  private func createTitle(title: String) {
    let label = UILabel()
    addSubview(label)
    label.text = title
    
    addTitleLayoutConstraints(label)
    applyTitleStyle(label)
  }
  
  private func addTitleLayoutConstraints(label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    
    
    // Make the width of the title label the same as the view, minus the margins.
    TegAutolayoutConstraints.fillParent(label, parentView: self,
      margin: style.title.horizontalMargin, vertically: false)
    
    // Center the label vertically in the view with an offset.
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
  
  // MARK: - Button
  
  private func createButton(title: String) {
    let button = UIButton()
    addSubview(button)
    button.setTitle(title, forState: .Normal)
    addButtonLayoutConstraints(button)
    applyButtonStyle(button)
  }
  
  private func addButtonLayoutConstraints(button: UIButton) {
    guard let titleLabel = titleLabel else { return }
    button.translatesAutoresizingMaskIntoConstraints = false
    
    // Make the width of the button the same as the view, minus the margins.
    TegAutolayoutConstraints.fillParent(button, parentView: self, margin: style.title.horizontalMargin, vertically: false)
    
    // Position the button under the title label
    TegAutolayoutConstraints.twoViewsNextToEachOther(titleLabel, viewTwo: button, constraintContainer: self, margin: 20, vertically: true)
  }
  
  private func applyButtonStyle(button: UIButton) {
    button.setTitleColor(style.button.color, forState: .Normal)
    button.setTitleShadowColor(style.button.shadowColor, forState: .Normal)
    
    
    button.layer.borderColor = style.button.borderColor.CGColor
    
    button.titleEdgeInsets = UIEdgeInsets(top: style.button.borderMargin.height,
      left: style.button.borderMargin.width,
      bottom: style.button.borderMargin.height,
      right: style.button.borderMargin.width)
    
    button.layer.borderWidth = style.button.borderWidth

    guard let label = button.titleLabel else { return }
    
    label.font = style.button.font
    label.numberOfLines = style.button.numberOfLines
    label.shadowOffset = style.button.shadowOffset
  }
}