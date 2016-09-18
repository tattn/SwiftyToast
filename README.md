# SwiftyToast

[![CocoaPods Status](https://cocoapod-badges.herokuapp.com/v/TTToast/badge.png)](https://cocoapods.org/?q=tttoast)
![License](https://cocoapod-badges.herokuapp.com/l/TTToast/badge.png)

A simple toast library written by Swift

<a target="_blank" href="https://raw.githubusercontent.com/tattn/TTToast/assets/tttoast.gif">
<img width="30%" height="30%" alt="TTToast" src="https://raw.githubusercontent.com/tattn/TTToast/assets/tttoast.gif"></a>

## Installation

### Carthage

```
github "tattn/SwiftyToast"
```

### CocoaPods
Install with CocoaPods by adding the following to your Podfile:
```ruby
platform :ios, '8.0'
pod 'SwiftyToast'
```

### Manually
Add manually:

1. Add SwiftyToast.swift to your project.
2. Link QuartzCore.

## Examples

```swift
// simple
SwiftyToast.show("Hello world\nToast test")

// customization
SwiftyToast.show("Hello world\nToast test", view:self.view) { config in
	// appearance
	config.maxWidth = 0.8
	config.paddingHorizontal = 10.0
	config.paddingVertical = 10.0
	config.cornerRadius = 8
	config.alpha = 0.5
	config.font = UIFont(name: "SnellRoundhand", size: 25.0)
	config.textColor = UIColor(red: 0.192, green: 0.216, blue: 0.082, alpha: 1.0)
	config.backgroundColor = UIColor(red: 0.886, green: 0.976, blue: 0.72, alpha: 1.0)
	// shadow
	config.shadow = true
	config.shadowOpacity = 0.5
	config.shadowRadius = 10.0
	config.shadowOffset = CGSize(width: 4.0, height: 4.0)
	config.shadowColor = UIColor(red: 0.576, green: 0.624, blue: 0.36, alpha: 1.0).cgColor
	// duration
	config.durationBefore = 1.0
	config.duration = 2.0
	config.durationAfter = 0.5
	// position
	config.position = SwiftyToast.Position.bottom.rawValue | SwiftyToast.Position.right.rawValue
}

// global settings
SwiftyToast.config.backgroundColor = .black
SwiftyToast.config.textColor = .white
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

SwiftyToast is released under the MIT license. See LICENSE for details.
