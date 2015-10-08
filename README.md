> 🚧🚧🚧 This is work in progress 🚧🚧🚧

# Glyptodon, a UI widget for displaying 'no content' message in iOS

This is a UI element for iOS that shows 'no content' message with an optional button. It can be used on screens with optional content. When the content is empty we may want to inform the user why it is empty and suggest an action. For example, consider we have an ecommerce app with a shopping cart screen that  shows the list of products. If the user goes to the empty cart screen we can show a "Cart is empty" message and a "Go shopping" button.

<img src='https://raw.githubusercontent.com/exchangegroup/Glyptodon/master/Graphics/Drawings/Glyptodon_Riha2000.jpg' alt='UI widget for displaying 'no results' message in iOS' width='450'>

*A large extinct armadillo on his walk round the Guayana highlands. Image by Pavel Riha. Source: [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Glyptodon_(Riha2000).jpg).*

## Setup

There are three ways you can add Glyptodon to your project.

**Add source (iOS 7+)**

Simply add [GlyptodonDistrib.swift](https://github.com/exchangegroup/Glyptodon/blob/master/Distrib/GlyptodonDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Add `github "exchangegroup/Glyptodon" ~> 2.0` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'Glyptodon', '~> 2.0'

## Usage

Add `import Glyptodon` to your source code if you used Carthage or CocoaPods setup methods.

Glyptodon is an extension of UIView class. You can reach it by using using the `glyptodon` property in any instance of UIView or its subclass. It can be, for example, the `view` property of your view controller.


### Show and hide message view


```Swift
view.glyptodon.show("No new message")
view.glyptodon.hide()

// Check if the view is currently visible
view.glyptodon.visible
```

### Show message with a button and a tap handler

```Swift
view.glyptodon.show("Cart is empty", buttonLabel: 'Go shopping') {
  // Called when button is tapped.
}
```

### Styling

Set `glyptodon.style` property to style the view **before** it is shown.

```Swift
// Set the view background color
view.glyptodon.style.view.backgroundColor = GlyptodonColor.fromHexString("#EEEEEE")

// Set the title font
view.glyptodon.style.title.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)

// Set the title color
view.glyptodon.style.title.color = GlyptodonColor.fromHexString("#666666")

// Set the button font
view.glyptodon.style.button.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)

// Set the button color
view.glyptodon.style.button.color = UIColor.blueColor()
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