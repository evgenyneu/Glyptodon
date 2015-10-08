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
    
    XCTAssertEqual("My test message", glyptodonLabel(superview)?.text)
  }
  
  // MARK: - Style
  
  func testStyleLabel_font() {
  }
}