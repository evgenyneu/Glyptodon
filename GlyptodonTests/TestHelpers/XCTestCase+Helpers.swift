import UIKit
import XCTest
@testable import Glyptodon

extension XCTestCase {
  func glyptodonView(superview: UIView) -> GlyptodonView? {
    if superview.subviews.count == 0 { return nil }
    
    let views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }
    
    guard let view = views.first else { return nil }
    
    return view
  }
  
  func glyptodonLabel(superview: UIView) -> UILabel? {
    return glyptodonView(superview)?.subviews.filter { $0 is UILabel }.map { $0 as! UILabel }.first
  }
  
  func glyptodonButton(superview: UIView) -> UIButton? {
    guard let view = glyptodonView(superview) else { return nil }
      
    return view.subviews.filter { $0 is UIButton }.map { $0 as! UIButton }.first
  }
}