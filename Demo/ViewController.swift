import UIKit
import Glyptodon

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func didTapShowButton(sender: AnyObject) {
    view.glyptodon.show("No new messages.")
  }
}

