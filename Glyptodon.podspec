Pod::Spec.new do |s|
  s.name        = "Glyptodon"
  s.version     = "2.0.0"
  s.license     = { :type => "MIT" }
  s.homepage    = "https://github.com/marketplacer/Glyptodon"
  s.summary     = "A 'no content' message overlay for iOS written in Swift."
  s.description  = <<-DESC
                   This is an iOS library for showing a 'no content' message over an existing view. It can be used to show a missing content message and suggest an action.

                   For example, consider we have an ecommerce app with a shopping cart screen that shows a list of products. If the user goes to the empty cart screen we can show an "Empty cart" message and a "Search" button.
                   DESC
  s.authors     = { "Evgenii Neumerzhitckii" => "sausageskin@gmail.com" }
  s.source      = { :git => "https://github.com/marketplacer/Glyptodon.git", :tag => s.version }
  s.screenshots  = "https://raw.githubusercontent.com/marketplacer/Glyptodon/master/Graphics/Glyptodon_logo.png"
  s.source_files = "Glyptodon/**/*.swift"
  s.ios.deployment_target = "8.0"
end