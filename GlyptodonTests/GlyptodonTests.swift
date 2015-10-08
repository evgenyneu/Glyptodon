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
  
  func testThis() {
    obj.show("Nothing here")
    
    XCTAssert(glyptodonView(superview) != nil)
  }
}