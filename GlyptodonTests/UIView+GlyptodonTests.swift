import UIKit
import XCTest
@testable import Glyptodon

class UIViewGlyptodonExtensionTests: XCTestCase {
  func testGetCreatesAndStoresGlyptodonInstance() {
    let view = UIView()
    let glyptodon1 = view.glyptodon
    let glyptodon2 = view.glyptodon
    
    XCTAssert(glyptodon1 === glyptodon2)
  }
}