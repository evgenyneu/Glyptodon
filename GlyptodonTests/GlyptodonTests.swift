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
  
  // MARK : - Show
  
  func testShow() {
    obj.show("Nothing here")
    
    XCTAssertEqual("Nothing here", glyptodonTitleLabel(superview)?.text)
  }
}