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

### Styling

Set `glyptodon.style` property to style the view **before** it is shown.

```Swift
view.glyptodon.style.view.backgroundColor = UIColor.grayColor()

// Set the message font
view.glyptodon.style.message.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)

// Set the message color
view.glyptodon.style.message.color = UIColor.blackColor()

// Set the button font
view.glyptodon.style.button.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)

// Set the button color
view.glyptodon.style.button.color = UIColor.yellowColor()
```

### Customize animation

Configure the animation effect of the view before it is shown.


```Swift
// Use existing animations
view.glyptodon.style.bar.animationShow = GlyptodonAnimations.Fade.show
view.glyptodon.style.bar.animationHide = GlyptodonAnimations.Fade.hide

// Turn off animation
view.glyptodon.style.bar.animationShow = GlyptodonAnimations.NoAnimation.show
```

## License

Glyptodon is released under the [MIT License](LICENSE).