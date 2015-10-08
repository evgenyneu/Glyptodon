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
    obj.showInSuperview(superview, withTitle: "My test message")
    
    XCTAssert(glyptodonView(superview) != nil)
  }
  
  func testShow_message() {
    obj.showInSuperview(superview, withTitle: "My test message")
    
    XCTAssertEqual("My test message", glyptodonTitleLabel(superview)?.text)
  }
  
  // MARK: - Hide
  
  func testHide() {
    obj.showInSuperview(superview, withTitle: "My test message")
    obj.hide()
    XCTAssert(glyptodonView(superview) == nil)
  }
  
  // MARK: - Style
  
  func testStyleLabel() {
    style.title.font = UIFont.systemFontOfSize(38.31)
    style.title.color = UIColor.purpleColor()
    style.title.numberOfLines = 3
    style.title.shadowColor = UIColor.yellowColor()
    style.title.shadowOffset = CGSize(width: 3, height: 2)
    
    obj.showInSuperview(superview, withTitle: "My test message")
    
    XCTAssertEqual(38.31, glyptodonTitleLabel(superview)?.font.pointSize)
    XCTAssertEqual(UIColor.purpleColor(), glyptodonTitleLabel(superview)?.textColor)
    XCTAssertEqual(3, glyptodonTitleLabel(superview)?.numberOfLines)
    XCTAssertEqual(UIColor.yellowColor(), glyptodonTitleLabel(superview)?.shadowColor)
    XCTAssertEqual(CGSize(width: 3, height: 2), glyptodonTitleLabel(superview)?.shadowOffset)
  }
}