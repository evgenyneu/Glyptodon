//
//  TegAlign.swift
//
//  Collection of shortcuts to create autolayout constraints.
//

import UIKit

class TegAutolayoutConstraints {
  class func centerX(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer,
      vertically: false, constant: constant)
  }
  
  @discardableResult
  class func centerY(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer,
      vertically: true, constant: constant)
  }
  
  fileprivate class func center(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, vertically: Bool = false, constant: CGFloat = 0) -> [NSLayoutConstraint] {
      
    let attribute = vertically ? NSLayoutAttribute.centerY : NSLayoutAttribute.centerX
    
    let constraint = NSLayoutConstraint(
      item: viewOne,
      attribute: attribute,
      relatedBy: NSLayoutRelation.equal,
      toItem: viewTwo,
      attribute: attribute,
      multiplier: 1,
      constant: constant)
    
    constraintContainer.addConstraint(constraint)
    
    return [constraint]
  }
  
  class func fillParent(_ view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool) {
    var marginFormat = ""
    
    if margin != 0 {
      marginFormat = "-\(margin)-"
    }
    
    var format = "|\(marginFormat)[view]\(marginFormat)|"
    
    if vertically {
      format = "V:" + format
    }
    
    let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
      options: [], metrics: nil,
      views: ["view": view])
    
    parentView.addConstraints(constraints)
  }
  
  @discardableResult
  class func twoViewsNextToEachOther(_ viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
      var marginFormat = ""
      
      if margin != 0 {
        marginFormat = "-\(margin)-"
      }
      
      var format = "[viewOne]\(marginFormat)[viewTwo]"
      
      if vertically {
        format = "V:" + format
      }
      
      let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
        options: [], metrics: nil,
        views: [ "viewOne": viewOne, "viewTwo": viewTwo ])
      
      constraintContainer.addConstraints(constraints)
      
      return constraints
  }
}
