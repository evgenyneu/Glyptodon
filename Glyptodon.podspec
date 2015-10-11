Pod::Spec.new do |s|
  s.name        = "Glyptodon"
  s.version     = "1.0.2"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/exchangegroup/Glyptodon"
  s.summary     = "A UI widget for displaying 'no content' message in iOS written in Swift"
  s.description  = <<-DESC
                   This is a UI element for iOS that shows a 'no content' message over an existing view. It can be used to show a missing content message and suggest an action.

                   For example, consider we have an ecommerce app with a shopping cart screen that shows a list of products. If the user goes to the empty cart screen we can show a "Cart is empty" message and a "Search" button.
                   DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/exchangegroup/Glyptodon.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/exchangegroup/Dodo/master/Graphics/Paintings/alices_adventures_in_wonderland.png"
  s.source_files = "Glyptodon/**/*.swift"
  s.resources  = "Glyptodon/**/*.xcassets"
  s.ios.deployment_target = "8.0"
end