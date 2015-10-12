import UIKit

class GlyptodonView: UIView {
  var style: GlyptodonStyle
  
  /// Shows if the view is being hidden
  var beingHidden = false
  
  /// Button tap closure supplied by the user
  var didTapButtonHandler: (()->())?
  
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
  
  func showInSuperview(superview: UIView, title: String, withAnimation: Bool,
    didFinishAnimation: ()->()) {
      
    superview.addSubview(self)
    addLayoutConstraints()
    createTitle(title)
    applyStyle()
    
    if withAnimation {
      animateIn() { didFinishAnimation() }
    } else {
      didFinishAnimation()
    }
  }
  
  func showInSuperview(superview: UIView, title: String,
    withButton buttonTitle: String, withAnimation: Bool, didTapButton: ()->(),
    didFinishAnimation: ()->()) {
    
    showInSuperview(superview, title: title, withAnimation: withAnimation,
      didFinishAnimation: didFinishAnimation)
      
    self.didTapButtonHandler = didTapButton
    createButton(buttonTitle)
  }
  
  func hide(withAnimation withAnimation: Bool, didFinishAnimation: ()->()) {
    if beingHidden {
      didFinishAnimation()
      return
    }
    
    beingHidden = true
    
    if withAnimation {
      animateOut() { [weak self] in
        self?.removeFromSuperview()
        didFinishAnimation()
      }
    } else {
      removeFromSuperview()
      didFinishAnimation()
    }
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
    setupTapHandler(button)
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
    button.setTitleColor(style.button.colorHighlighted, forState: .Highlighted)
    
    button.setTitleShadowColor(style.button.shadowColor, forState: .Normal)
    
    guard let label = button.titleLabel else { return }
    
    label.font = style.button.font
    label.numberOfLines = style.button.numberOfLines
    label.shadowOffset = style.button.shadowOffset
  }
  
  private func setupTapHandler(button: UIButton) {
    button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
  }
  
  func didTapButton(button: UIButton) {
    didTapButtonHandler?()
  }
  
  // MARK: - Animation
  
  private func animateIn(didFinishAnimation: ()->()) {
    alpha = 0
    
    UIView.animateWithDuration(style.view.animationDurationSeconds,
      animations: { [weak self] in
        self?.alpha = 1
      },
      completion: { _ in
        didFinishAnimation()
      }
    )
  }
  
  private func animateOut(didFinishAnimation: ()->()) {
    UIView.animateWithDuration(style.view.animationDurationSeconds,
      animations: { [weak self] in
        self?.alpha = 0
      },
      completion: { _ in
        didFinishAnimation()
      }
    )
  }
}