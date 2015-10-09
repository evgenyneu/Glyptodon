import UIKit
import Glyptodon

class ViewController: UIViewController {
  @IBOutlet var showHideButton: UIBarButtonItem!
  @IBOutlet var withButtonSwitch: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateButtonTitle()
    
    GlyptodonViewDefaultStyles.backgroundColor = GlyptodonColor.fromHexString("#FFF4D1")
    GlyptodonTitleDefaultStyles.color = GlyptodonColor.fromHexString("#455840")
    GlyptodonButtonDefaultStyles.color = GlyptodonColor.fromHexString("#7CB06F")
  }

  @IBAction func didTapShowButton(sender: AnyObject) {
    showMessageView()
  }
  
  @IBAction func didTapShowButtonSwitch(sender: AnyObject) {
    showMessageView()
  }
  
  private func updateButtonTitle() {
    showHideButton.title = view.glyptodon.visible ? "Hide" : "Show"
  }
  
  private func showMessageView() {
    if view.glyptodon.visible {
      view.glyptodon.hide()
      updateButtonTitle()
      return
    }
    
    if withButtonSwitch.on {
      view.glyptodon.show("Why is there something rather then nothing?", withButton: "Get an answer") { [weak self] in
        self?.view.glyptodon.show("Because 'nothing' is unstable.", withAnimation: false)
      }
    } else {
      view.glyptodon.show("There is nothing here.")
    }
    
    updateButtonTitle()
  }
}