# Glyptodon, a UI widget for displaying 'no results' message in iOS

This is a UI element for showing 'no results' message in iOS.

<img src='https://raw.githubusercontent.com/exchangegroup/glyptodon/master/Graphics/Drawings/Glyptodon_Riha2000.jpg' alt='UI widget for displaying 'no results' message in iOS' width='450'>

*A large extinct armadillo on his walk round the Guayana highlands. Image by Pavel Riha. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Glyptodon_(Riha2000).jpg).*

## Usage

Add `import Glyptodon` to your source code if you used Carthage or CocoaPods setup methods.

Glyptodon is an extension of UIView class. You can reach it by using using the `glyptodon` property in any instance of UIView or its subclass. It can be, for example, the `view` property of your view controller.


### Show and hide message view


```Swift
view.glyptodon.show("No new message")
view.glyptodon.hide()
```

### Show message with a button and a tap handler

```Swift
view.glyptodon.show("Shopping cart is empty.", buttonLabel: 'Go shopping') {
  // Called when button is tapped.
}
```

## License

Glyptodon is released under the [MIT License](LICENSE).