import UIKit
import XCTest
@testable import Glyptodon

class GlyptodonViewTests: XCTestCase {
  var obj: GlyptodonView!
  var superview: UIView!
  var style: GlyptodonStyle!
  
  override func setUp() {
    super.setUp()
    
    style = GlyptodonStyle()
    obj = GlyptodonView(style: style)
    superview = UIView()
  }
  
  // MARK: - Show
  
  func testShow_withAnimation() {
    obj.showInSuperview(superview, title: "My test message", withAnimation: true) { }
    
    XCTAssert(glyptodonView(superview) != nil)
  }
  
  func testShow_noAnimation() {
    obj.showInSuperview(superview, title: "My test message", withAnimation: false) { }
    
    XCTAssert(glyptodonView(superview) != nil)
  }
  
  func testShow_message() {
    obj.showInSuperview(superview, title: "My test message", withAnimation: false) { }
    
    XCTAssertEqual("My test message", glyptodonTitleLabel(superview)?.text)
  }
  
  // MARK: - Show with button
  
  func testShowWithButton_withAnimation() {
    obj.showInSuperview(superview, title: "My test message", withButton: "Continue",
      withAnimation: true, didTapButton: { }) { }
    
    XCTAssertEqual("Continue", glyptodonButton(superview)?.titleLabel?.text)
  }
  
  func testShowWithButton_noAnimation() {
    obj.showInSuperview(superview, title: "My test message", withButton: "Continue",
      withAnimation: false, didTapButton: { }) { }
    
    XCTAssertEqual("Continue", glyptodonButton(superview)?.titleLabel?.text)
  }
  
  func testShowWithButton_callClosureOnTap() {
    var didCallClosure = false
    
    obj.showInSuperview(superview, title: "My test message", withButton: "Continue",
      withAnimation: true, didTapButton: {
        
        didCallClosure = true
      }
    ) { }
    
    let view = glyptodonView(superview)!
    view.didTapButtonHandler?()
    
    XCTAssert(didCallClosure)
  }
  
  // MARK: - Hide
  
  func testHide_withAnimation() {
    let expectation = expectationWithDescription("view is removed")

    obj.showInSuperview(superview, title: "My test message", withAnimation: true) { }
    
    XCTAssertFalse(glyptodonView(superview)!.beingHidden)
    
    obj.hide(withAnimation: true) { expectation.fulfill() }
      
    XCTAssert(glyptodonView(superview)!.beingHidden)
    
    waitForExpectationsWithTimeout(0.5, handler: nil)
    XCTAssert(glyptodonView(superview) == nil)
  }
  
  func testHide_noAnimation() {
    var didCallClosure = false
    
    obj.showInSuperview(superview, title: "My test message", withAnimation: true) { }
    XCTAssertFalse(glyptodonView(superview)!.beingHidden)
    
    obj.hide(withAnimation: false) { didCallClosure = true }
    
    XCTAssert(glyptodonView(superview) == nil)
    XCTAssert(didCallClosure)
  }
  
  // MARK: - Style
  
  func testStyleLabel() {
    style.title.font = UIFont.systemFontOfSize(38.31)
    style.title.color = UIColor.purpleColor()
    style.title.numberOfLines = 3
    style.title.shadowColor = UIColor.yellowColor()
    style.title.shadowOffset = CGSize(width: 3, height: 2)
    
    obj.showInSuperview(superview, title: "My test message", withAnimation: true) { }
    
    XCTAssertEqual(38.31, glyptodonTitleLabel(superview)?.font.pointSize)
    XCTAssertEqual(UIColor.purpleColor(), glyptodonTitleLabel(superview)?.textColor)
    XCTAssertEqual(3, glyptodonTitleLabel(superview)?.numberOfLines)
    XCTAssertEqual(UIColor.yellowColor(), glyptodonTitleLabel(superview)?.shadowColor)
    XCTAssertEqual(CGSize(width: 3, height: 2), glyptodonTitleLabel(superview)?.shadowOffset)
  }
  
  func testStyleButton() {
    style.button.font = UIFont.systemFontOfSize(12.31)
    style.button.color = UIColor.purpleColor()
    style.button.numberOfLines = 3
    style.button.shadowColor = UIColor.yellowColor()
    style.button.shadowOffset = CGSize(width: 3, height: 2)
    
    obj.showInSuperview(superview, title: "Empty", withButton: "Continue", withAnimation: true,
      didTapButton: {}) { }
    
    let button = glyptodonButton(superview)!
    let buttonLabel = button.titleLabel
    
    XCTAssertEqual(12.31, buttonLabel?.font.pointSize)
    XCTAssertEqual(UIColor.purpleColor(), button.titleColorForState(.Normal))
    XCTAssertEqual(3, buttonLabel?.numberOfLines)
    XCTAssertEqual(UIColor.yellowColor(), button.titleShadowColorForState(.Normal))
    XCTAssertEqual(CGSize(width: 3, height: 2), buttonLabel?.shadowOffset)
  }
}