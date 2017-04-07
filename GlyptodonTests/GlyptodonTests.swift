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
    var expectation = self.expectation(description: "did show")
    obj.didFinishShowAnimation = { expectation.fulfill() }
    
    // Show first view
    obj.show("Message 1")
    waitForExpectations(timeout: 0.5, handler: nil)
    
    // Show second view
    expectation = self.expectation(description: "did show")
    obj.show("Message 2")
    
    // There are two views currently shown
    var views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }
    XCTAssertEqual(2, views.count)
  
    // Wait for the second view to finish show animation, that's when it will remove the previous view.
    waitForExpectations(timeout: 0.5, handler: nil)
    
    // There should be only one view present
    views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }
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
    var expectation = self.expectation(description: "did show")
    obj.didFinishShowAnimation = { expectation.fulfill() }
    
    // Show first view
    obj.show("Message 1", withButton: "Continue 1") { }
    waitForExpectations(timeout: 0.5, handler: nil)
    
    // Show second view
    expectation = self.expectation(description: "did show")
    obj.show("Message 2", withButton: "Continue 2") { }
    
    // There are two views currently shown
    var views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }
    XCTAssertEqual(2, views.count)

    // Wait for the second view to finish show animation, that's when it will remove the previous view.
    waitForExpectations(timeout: 0.5, handler: nil)
    
    // There should be only one view present
    views = superview.subviews.filter { $0 is GlyptodonView }.map { $0 as! GlyptodonView }
    XCTAssertEqual(1, views.count)
    XCTAssertEqual("Continue 2", glyptodonButton(superview)?.titleLabel?.text)
  }
  
  // MARK: - Hide
  
  func testHide() {
    let expectation = self.expectation(description: "did hide")
    obj.didFinishHideAnimation = { expectation.fulfill() }
    
    obj.show("Nothing here")

    obj.hide()

    waitForExpectations(timeout: 0.5, handler: nil)
    XCTAssert(glyptodonView(superview) == nil)
  }
  
  func testHideMultipleViews_edgeCase() {
    let expectation = self.expectation(description: "did hide")
    obj.didFinishHideAnimation = { expectation.fulfill() }
    
    var view = GlyptodonView()
    superview.addSubview(view)
    
    view = GlyptodonView()
    superview.addSubview(view)
    
    obj.hide()
    
    waitForExpectations(timeout: 0.5, handler: nil)
    XCTAssert(glyptodonView(superview) == nil)
  }
  
  // MARK: - Visible
  
  func testVisible() {
    obj.show("Nothing here")
    XCTAssert(obj.visible)
    
    let expectation = self.expectation(description: "did hide")
    obj.didFinishHideAnimation = { expectation.fulfill() }
    
    obj.hide()
    XCTAssertFalse(obj.visible)
    
    waitForExpectations(timeout: 0.5, handler: nil)
    XCTAssertFalse(obj.visible)
  }
  
  // MARK: - Title
  
  func testTitleLabel() {
    obj.show("Nothing here")
    XCTAssertEqual("Nothing here", obj.titleLabel?.text)
  }
  
  func testTitle_missing() {
    XCTAssert(obj.titleLabel == nil)
  }
  
  // MARK: - Button
  
  func testButton() {
    obj.show("Nothing here", withButton: "Continue") { }
    XCTAssertEqual("Continue", obj.button?.titleLabel?.text)
  }
  
  func testButton_missing() {
    XCTAssert(obj.button == nil)
  }
}
