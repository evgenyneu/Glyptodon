# A 'no content' message overlay for iOS

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)][carthage]
[![CocoaPods Version](https://img.shields.io/cocoapods/v/Glyptodon.svg?style=flat)][cocoadocs]
[![License](https://img.shields.io/cocoapods/l/Glyptodon.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/Glyptodon.svg?style=flat)][cocoadocs]
[cocoadocs]: http://cocoadocs.org/docsets/Glyptodon
[carthage]: https://github.com/Carthage/Carthage

This is a UI widget for iOS written in Swift. It shows a 'no content' message over an existing view. It can be used to show a missing content message and suggest an action.

For example, consider we have an ecommerce app with a shopping cart screen that shows a list of products. If the user goes to the empty cart screen we can show a "Cart is empty" message and a "Search" button.

<img src='https://raw.githubusercontent.com/exchangegroup/Glyptodon/master/Graphics/screenshots/glyptodon_ios_screenshot_2.png' width='320' alt='Glyptodon iOS message view example'>

Glyptodon allows to show such a message over an existing view:

```Swift
view.glyptodon.show("Cart is empty", withButton: "Search") {
  // User has tapped the "Search" button.
}
```

## Setup

There are three ways you can add Glyptodon to your project.

**Add source (iOS 7+)**

Simply add [GlyptodonDistrib.swift](https://github.com/exchangegroup/Glyptodon/blob/master/Distrib/GlyptodonDistrib.swift) file into your Xcode project.

**Setup with Carthage (iOS 8+)**

Add `github "exchangegroup/Glyptodon" ~> 1.0` to your Cartfile and run `carthage update`.

**Setup with CocoaPods (iOS 8+)**

If you are using CocoaPods add this text to your Podfile and run `pod install`.

    use_frameworks!
    pod 'Glyptodon', '~> 1.0'

## Usage

Add `import Glyptodon` to your source code if you used Carthage or CocoaPods setup methods.

Glyptodon is an extension of UIView class. You can reach it by using using the `glyptodon` property in any instance of UIView or its subclass. It can be, for example, the `view` property of your view controller.


### Show and hide message view


```Swift
// Show message
view.glyptodon.show("No new messages")

// Hide message
view.glyptodon.hide()

// Show message with a button
view.glyptodon.show("Cart is empty", withButton: "Go shopping") {
  // Do something when the button is tapped.
}
```

### Styling

Set `glyptodon.style` property to style the view **before** it is shown. See the [styling manual](https://github.com/exchangegroup/Glyptodon/wiki/Styling) for the complete list of configuration options.

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
view.glyptodon.style.button.color = GlyptodonColor.fromHexString("#007AFF")

// Set the color of the tapped button
view.glyptodon.style.button.colorHighlighted = GlyptodonColor.fromHexString("#007AFF33")
```

### Unit testing

Sometimes it is useful to verify the presence of the message view and its content in the unit test. The library provides the following helper properties to make unit testing easier.

```Swift
// Indicates if the view is currently visible
view.glyptodon.visible

// Returns the currently displayed title label
view.glyptodon.titleLabel

// Returns the currently displayed button
view.glyptodon.button
```

## Demo

This project includes a demo iOS app.

<img src='https://raw.githubusercontent.com/exchangegroup/Glyptodon/master/Graphics/screenshots/glyptodon_demo_ios_app.png' alt='Glyptodon demo iOS app' width='320'>

## License

Glyptodon library is released under the [MIT License](LICENSE).


<img src='https://raw.githubusercontent.com/exchangegroup/Glyptodon/master/Graphics/Glyptodon_in_space_logo_3.png' alt='Glyptodon library for iOS' width='128'>
