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
    let expectation = self.expectation(description: "view is removed")

    obj.showInSuperview(superview, title: "My test message", withAnimation: true) { }
    
    XCTAssertFalse(glyptodonView(superview)!.beingHidden)
    
    obj.hide(withAnimation: true) { expectation.fulfill() }
      
    XCTAssert(glyptodonView(superview)!.beingHidden)
    
    waitForExpectations(timeout: 0.5, handler: nil)
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
    style.title.font = UIFont.systemFont(ofSize: 38.31)
    style.title.color = UIColor.purple
    style.title.numberOfLines = 3
    style.title.shadowColor = UIColor.yellow
    style.title.shadowOffset = CGSize(width: 3, height: 2)
    
    obj.showInSuperview(superview, title: "My test message", withAnimation: true) { }
    
    XCTAssertEqual(38.31, glyptodonTitleLabel(superview)?.font.pointSize)
    XCTAssertEqual(UIColor.purple, glyptodonTitleLabel(superview)?.textColor)
    XCTAssertEqual(3, glyptodonTitleLabel(superview)?.numberOfLines)
    XCTAssertEqual(UIColor.yellow, glyptodonTitleLabel(superview)?.shadowColor)
    XCTAssertEqual(CGSize(width: 3, height: 2), glyptodonTitleLabel(superview)?.shadowOffset)
  }
  
  func testStyleButton() {
    style.button.font = UIFont.systemFont(ofSize: 12.31)
    style.button.color = UIColor.purple
    style.button.numberOfLines = 3
    style.button.shadowColor = UIColor.yellow
    style.button.shadowOffset = CGSize(width: 3, height: 2)
    
    obj.showInSuperview(superview, title: "Empty", withButton: "Continue", withAnimation: true,
      didTapButton: {}) { }
    
    let button = glyptodonButton(superview)!
    let buttonLabel = button.titleLabel
    
    XCTAssertEqual(12.31, buttonLabel?.font.pointSize)
    XCTAssertEqual(UIColor.purple, button.titleColor(for: UIControlState()))
    XCTAssertEqual(3, buttonLabel?.numberOfLines)
    XCTAssertEqual(UIColor.yellow, button.titleShadowColor(for: UIControlState()))
    XCTAssertEqual(CGSize(width: 3, height: 2), buttonLabel?.shadowOffset)
  }
}
