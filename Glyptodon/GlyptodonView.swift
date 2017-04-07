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
  
  func showInSuperview(_ superview: UIView, title: String, withAnimation: Bool,
    didFinishAnimation: @escaping ()->()) {
      
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
  
  func showInSuperview(_ superview: UIView, title: String,
    withButton buttonTitle: String, withAnimation: Bool, didTapButton: @escaping ()->(),
    didFinishAnimation: @escaping ()->()) {
    
    showInSuperview(superview, title: title, withAnimation: withAnimation,
      didFinishAnimation: didFinishAnimation)
      
    self.didTapButtonHandler = didTapButton
    createButton(buttonTitle)
  }
  
  func hide(withAnimation: Bool, didFinishAnimation: @escaping ()->()) {
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
  
  fileprivate func applyStyle() {
    backgroundColor = style.view.backgroundColor
  }
  
  fileprivate func addLayoutConstraints() {
    guard let superview = superview else { return }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    // Fill the message view to covert entire area of its superview
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: true)
    TegAutolayoutConstraints.fillParent(self, parentView: superview, margin: 0, vertically: false)
  }
  
  fileprivate var titleLabel: UILabel? {
    return subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
  }
  
  // MARK: - Title
  
  fileprivate func createTitle(_ title: String) {
    let label = UILabel()
    addSubview(label)
    label.text = title
    
    addTitleLayoutConstraints(label)
    applyTitleStyle(label)
  }
  
  fileprivate func addTitleLayoutConstraints(_ label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    
    // Make the width of the title label the same as the view, minus the margins.
    TegAutolayoutConstraints.fillParent(label, parentView: self,
      margin: style.title.horizontalMargin, vertically: false)
    
    // Center the label vertically in the view with an offset.
    TegAutolayoutConstraints.centerY(label, viewTwo: self, constraintContainer: self,
      constant: style.title.verticalOffset)
  }
  
  fileprivate func applyTitleStyle(_ label: UILabel) {
    label.textAlignment = .center
    label.font = style.title.font
    label.textColor = style.title.color
    label.numberOfLines = style.title.numberOfLines
    label.shadowColor = style.title.shadowColor
    label.shadowOffset = style.title.shadowOffset
  }
  
  // MARK: - Button
  
  fileprivate func createButton(_ title: String) {
    let button = UIButton()
    addSubview(button)
    button.setTitle(title, for: UIControlState())
    addButtonLayoutConstraints(button)
    applyButtonStyle(button)
    setupTapHandler(button)
  }
  
  fileprivate func addButtonLayoutConstraints(_ button: UIButton) {
    guard let titleLabel = titleLabel else { return }
    button.translatesAutoresizingMaskIntoConstraints = false
    
    // Make the width of the button the same as the view, minus the margins.
    TegAutolayoutConstraints.fillParent(button, parentView: self, margin: style.title.horizontalMargin, vertically: false)
    
    // Position the button under the title label
    TegAutolayoutConstraints.twoViewsNextToEachOther(titleLabel, viewTwo: button, constraintContainer: self, margin: 20, vertically: true)
  }
  
  fileprivate func applyButtonStyle(_ button: UIButton) {
    button.setTitleColor(style.button.color, for: UIControlState())
    button.setTitleColor(style.button.colorHighlighted, for: .highlighted)
    
    button.setTitleShadowColor(style.button.shadowColor, for: UIControlState())
    
    guard let label = button.titleLabel else { return }
    
    label.font = style.button.font
    label.numberOfLines = style.button.numberOfLines
    label.shadowOffset = style.button.shadowOffset
  }
  
  fileprivate func setupTapHandler(_ button: UIButton) {
    button.addTarget(self, action: #selector(GlyptodonView.didTapButton(_:)), for: .touchUpInside)
  }
  
  func didTapButton(_ button: UIButton) {
    didTapButtonHandler?()
  }
  
  // MARK: - Animation
  
  fileprivate func animateIn(_ didFinishAnimation: @escaping ()->()) {
    alpha = 0
    
    UIView.animate(withDuration: style.view.animationDurationSeconds,
      animations: { [weak self] in
        self?.alpha = 1
      },
      completion: { _ in
        didFinishAnimation()
      }
    )
  }
  
  fileprivate func animateOut(_ didFinishAnimation: @escaping ()->()) {
    UIView.animate(withDuration: style.view.animationDurationSeconds,
      animations: { [weak self] in
        self?.alpha = 0
      },
      completion: { _ in
        didFinishAnimation()
      }
    )
  }
}
