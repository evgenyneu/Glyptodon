import UIKit
import Glyptodon

class ViewController: UIViewController {
  @IBOutlet var showHideButton: UIBarButtonItem!
  @IBOutlet var withButtonSwitch: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateButtonTitle()
  }

  @IBAction func didTapShowButton(sender: AnyObject) {
    if view.glyptodon.visible {
      view.glyptodon.hide()
      updateButtonTitle()
      return
    }
    
    if withButtonSwitch.on {
      view.glyptodon.show("Screen is static", withButton: "Rotate") {
        print("Hello")
      }
    } else {
      view.glyptodon.show("No new messages")
    }
    
    updateButtonTitle()
  }
  
  private func updateButtonTitle() {
    showHideButton.title = view.glyptodon.visible ? "Hide" : "Show"
  }
}

