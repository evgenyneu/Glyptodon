//
//  TegAlign.swift
//
//  Collection of shortcuts to create autolayout constraints.
//

import UIKit

class TegAutolayoutConstraints {
  class func centerX(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer,
      vertically: false, constant: constant)
  }
  
  class func centerY(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer,
      vertically: true, constant: constant)
  }
  
  private class func center(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, vertically: Bool = false, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    let attribute = vertically ? NSLayoutAttribute.CenterY : NSLayoutAttribute.CenterX
    
    let constraint = NSLayoutConstraint(
      item: viewOne,
      attribute: attribute,
      relatedBy: NSLayoutRelation.Equal,
      toItem: viewTwo,
      attribute: attribute,
      multiplier: 1,
      constant: constant)
    
    constraintContainer.addConstraint(constraint)
    
    return [constraint]
  }
  
  class func fillParent(view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool) {
    var marginFormat = ""
    
    if margin != 0 {
      marginFormat = "-\(margin)-"
    }
    
    var format = "|\(marginFormat)[view]\(marginFormat)|"
    
    if vertically {
      format = "V:" + format
    }
    
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: [], metrics: nil,
      views: ["view": view])
    
    parentView.addConstraints(constraints)
  }
}
