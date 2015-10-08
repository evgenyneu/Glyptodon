import UIKit
import XCTest
@testable import Glyptodon

class GlyptodonViewTests: XCTestCase {
  var obj: GlyptodonView!
  var superview: UIView!
  
  override func setUp() {
    super.setUp()
    
    obj = GlyptodonView()
    superview = UIView()
  }
  
  // MARK: - Show
  
  func testShow() {
    obj.showInSuperview(superview, withMessage: "My test message")
    
    XCTAssert(glyptodonView(superview) != nil)
  }
  
  func testShow_messafge() {
    obj.showInSuperview(superview, withMessage: "My test message")
    
    XCTAssertEqual("My test message", glyptodonLabel(superview)?.text)
  }
}