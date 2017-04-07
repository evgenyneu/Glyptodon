import UIKit
import Glyptodon

class ViewController: UIViewController {
  @IBOutlet var showHideButton: UIBarButtonItem!
  @IBOutlet var withButtonSwitch: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    styleMessageView()
    updateButtonTitle()    
  }
  
  fileprivate func styleMessageView() {
    view.glyptodon.style.view.backgroundColor = GlyptodonColor.fromHexString("#FFF4D1")
    view.glyptodon.style.title.color = GlyptodonColor.fromHexString("#455840")
    view.glyptodon.style.button.color = GlyptodonColor.fromHexString("#7CB06F")
    view.glyptodon.style.button.colorHighlighted = GlyptodonColor.fromHexString("#7CB06F33")
  }

  @IBAction func didTapShowButton(_ sender: AnyObject) {
    showMessageView()
  }
  
  @IBAction func didTapShowButtonSwitch(_ sender: AnyObject) {
    showMessageView()
  }
  
  fileprivate func updateButtonTitle() {
    showHideButton.title = view.glyptodon.visible ? "Hide" : "Show"
  }
  
  fileprivate func showMessageView() {
    if view.glyptodon.visible {
      view.glyptodon.hide()
      updateButtonTitle()
      return
    }
    
    if withButtonSwitch.isOn {
      view.glyptodon.show("Why is there something rather then nothing?",
        withButton: "Get an answer") { [weak self] in
          
        self?.view.glyptodon.show("Because 'nothing' is unstable.")
      }
    } else {
      view.glyptodon.show("There is nothing here.")
    }
    
    updateButtonTitle()
  }
}
