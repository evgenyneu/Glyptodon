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
  
  func testShow_showOnceViewWhenCalledMultipleTimes() {
    obj.show("Message 1")
    obj.show("Message 2")
    
    let views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }

    XCTAssertEqual(1, views.count)
    XCTAssertEqual("Message 2", glyptodonTitleLabel(superview)?.text)
  }
  
  // MARK: - Show with button
  
  func testShowWithButton() {
    obj.show("Nothing here", withButton: "Continue") { }
    
    XCTAssertEqual("Nothing here", glyptodonTitleLabel(superview)?.text)
    XCTAssertEqual("Continue", glyptodonButton(superview)?.titleLabel?.text)
  }
  
  func testShowWithButton_showOnceViewWhenCalledMultipleTimes() {
    obj.show("Message 1", withButton: "Continue 1") { }
    obj.show("Message 2", withButton: "Continue 2") { }
    
    let views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }
    
    XCTAssertEqual(1, views.count)
    XCTAssertEqual("Continue 2", glyptodonButton(superview)?.titleLabel?.text)
  }
  
  // MARK: - Hide
  
  func testHide() {
    let expectation = expectationWithDescription("did hide")
    obj.didHide = { expectation.fulfill() }
    
    obj.show("Nothing here")
    obj.hide()

    waitForExpectationsWithTimeout(0.5, handler: nil)
    XCTAssert(glyptodonView(superview) == nil)
  }
  
  // MARK: - Visible
  
  func testVisible() {
    obj.show("Nothing here")
    XCTAssert(obj.visible)
    
    let expectation = expectationWithDescription("did hide")
    obj.didHide = { expectation.fulfill() }
    
    obj.hide()
    XCTAssertFalse(obj.visible)
    
    waitForExpectationsWithTimeout(0.5, handler: nil)
    XCTAssertFalse(obj.visible)
  }
}