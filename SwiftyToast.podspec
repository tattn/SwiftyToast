Pod::Spec.new do |s|

  s.name         = "SwiftyToast"
  s.version      = "0.0.2"
  s.summary      = "This is a simple toast library."

  s.homepage     = "https://github.com/tattn/SwiftyToast"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Tatsuya Tanaka" => "tatsuyars@yahoo.co.jp" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/tattn/SwiftyToast.git", :tag => "v#{s.version}" }
  s.source_files  = "SwiftyToast/SwiftyToast/*.{swift,h}"
  s.exclude_files = "Classes/Exclude"
  s.public_header_files = "SwiftyToast/SwiftyToast/SwiftyToast.h"

  s.frameworks   = 'UIKit', 'Foundation', 'QuartzCore'
  s.requires_arc = true
end
