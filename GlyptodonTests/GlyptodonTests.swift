import UIKit
import XCTest
@testable import Glyptodon

class GlyptodonTests: XCTestCase {
  var obj: Glyptodon!
  var superview: UIView!


  override func setUp() {
    super.setUp()
    
    superview = UIView()
    obj = Glyptodon(superview: superview)
  }
  
  // MARK: - Show
  
  func testShow() {
    obj.show("Nothing here")
    
    XCTAssertEqual("Nothing here", glyptodonTitleLabel(superview)?.text)
  }
  
  func testShowOnlyOneViewWhenCalledMultipleTimes() {
    obj.show("Message 1")
    obj.show("Message 2")
    
    let views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }

    XCTAssertEqual(1, views.count)
    XCTAssertEqual("Message 2", glyptodonTitleLabel(superview)?.text)
  }
  
  // MARK: - Hide
  
  func testHide() {
    obj.show("Nothing here")
    obj.hide()

    XCTAssert(glyptodonView(superview) == nil)
  }
  
  // MARK: - Visible
  
  func testVisible() {
    obj.show("Nothing here")
    XCTAssert(obj.visible)
    
    obj.hide()
    XCTAssertFalse(obj.visible)
  }
}