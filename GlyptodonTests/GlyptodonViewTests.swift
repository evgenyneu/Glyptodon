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
  
  func testShow() {
    obj.showInSuperview(superview, title: "My test message")
    
    XCTAssert(glyptodonView(superview) != nil)
  }
  
  func testShow_message() {
    obj.showInSuperview(superview, title: "My test message")
    
    XCTAssertEqual("My test message", glyptodonTitleLabel(superview)?.text)
  }
  
  // MARK: - Show with button
  
  func testShowWithButton() {
    obj.showInSuperview(superview, title: "My test message", withButton: "Continue") { }
    
    XCTAssertEqual("Continue", glyptodonButton(superview)?.titleLabel?.text)
  }
  
  // MARK: - Hide
  
  func testHide() {
    let expectation = expectationWithDescription("view is removed")

    obj.showInSuperview(superview, title: "My test message")
    XCTAssertFalse(glyptodonView(superview)!.beingHidden)
    
    obj.hide() { expectation.fulfill() }
      
    XCTAssert(glyptodonView(superview)!.beingHidden)
    
    waitForExpectationsWithTimeout(0.5, handler: nil)
    XCTAssert(glyptodonView(superview) == nil)
  }
  
  // MARK: - Style
  
  func testStyleLabel() {
    style.title.font = UIFont.systemFontOfSize(38.31)
    style.title.color = UIColor.purpleColor()
    style.title.numberOfLines = 3
    style.title.shadowColor = UIColor.yellowColor()
    style.title.shadowOffset = CGSize(width: 3, height: 2)
    
    obj.showInSuperview(superview, title: "My test message")
    
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
    
    obj.showInSuperview(superview, title: "Empty", withButton: "Continue", didTapButton: {})
    
    let button = glyptodonButton(superview)!
    let buttonLabel = button.titleLabel
    
    XCTAssertEqual(12.31, buttonLabel?.font.pointSize)
    XCTAssertEqual(UIColor.purpleColor(), button.titleColorForState(.Normal))
    XCTAssertEqual(3, buttonLabel?.numberOfLines)
    XCTAssertEqual(UIColor.yellowColor(), button.titleShadowColorForState(.Normal))
    XCTAssertEqual(CGSize(width: 3, height: 2), buttonLabel?.shadowOffset)
  }
}