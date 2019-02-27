![Sejima: User Interface Library in Swift](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/banner.png)

[![Documentation](https://img.shields.io/badge/Read_the-Docs-67ad5c.svg)](https://moveupwards.github.io/Sejima/)
[![Language: Swift 2, 3 and 4](https://img.shields.io/badge/language-swift%204-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 11+](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)
[![CocoaPods](https://img.shields.io/cocoapods/v/Sejima.svg)](http://cocoapods.org/pods/Sejima)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/c366453a6bc247bd847c4ad33f2cf37c)](https://app.codacy.com/app/MoveUpwardsDev/Sejima?utm_source=github.com&utm_medium=referral&utm_content=MoveUpwards/Sejima&utm_campaign=Badge_Grade_Settings)
![Build Status](https://app.bitrise.io/app/527234c879c3952a.svg?token=RCLpb4OfkyZcufMQ7bVCTQ)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/MoveUpwards/Sejima/blob/master/LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/MoveUpwards/Sejima.svg)](https://github.com/MoveUpwards/Sejima/graphs/contributors)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/moveupwards)

## Requirements

- iOS 11.0+
- Xcode 9.0+

## Installation

use [CocoaPods](https://cocoapods.org) with Podfile:
```shell
pod 'Sejima'
```

## Walkthrough

![Walkthrough](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/Screenshots/Walkthrough.png)

### Stroryboard

Create a view controller and add the component in your storyboard and add the following code.

```swift
class WalkthroughVC: UIViewController {
    @IBOutlet private weak var horizontalPager: MUHorizontalPager!
    @IBOutlet private weak var pageControl: MUPageControl!
    @IBOutlet private weak var button: MUButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Else scroll view will be visible on page animation
        view.clipsToBounds = true

        addScrollViews()
        horizontalPager.pageControl = pageControl
        horizontalPager.horizontalMargin = 20.0

        pageControl.backgroundColor = .clear
        pageControl.tintColors = [.red, .blue, .green, .orange, .lightGray]
        pageControl.currentPageIndicatorTintColor = .purple
        pageControl.enableTouchEvents = true
        pageControl.activeElementWidth = 32
        pageControl.elementSize = CGSize(width: 16, height: 16)
        pageControl.radius = 8
        pageControl.horizontalMargin = 20.0

        button.title = "SKIP"
        button.titleColor = .black
        button.titleHighlightedColor = .lightGray
    }

    private func addScrollViews() {
        let v1 = UIView()
        v1.backgroundColor = .red
        let v2 = UIView()
        v2.backgroundColor = .blue
        let v3 = UIView()
        v3.backgroundColor = .green
        let v4 = UIView()
        v4.backgroundColor = .orange
        let v5 = UIView()
        v5.backgroundColor = .lightGray
        horizontalPager.add(views: [v1, v2, v3, v4, v5], margin: 10.0)
    }
}
```

## License

Folding cell is released under the MIT license.
See [LICENSE](./LICENSE) for details.

If you use the open-source library in your project, please make sure to credit and backlink to www.moveupwards.dev
