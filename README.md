![Sejima: User Interface Library in Swift](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/banner.png)

[![Documentation](https://img.shields.io/badge/Read_the-Docs-67ad5c.svg)](https://moveupwards.github.io/Sejima/)
[![Language: Swift 2, 3 and 4](https://img.shields.io/badge/language-swift%205-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 11+](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/cocoapods/v/Sejima.svg)](http://cocoapods.org/pods/Sejima)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/c366453a6bc247bd847c4ad33f2cf37c)](https://app.codacy.com/app/MoveUpwardsDev/Sejima?utm_source=github.com&utm_medium=referral&utm_content=MoveUpwards/Sejima&utm_campaign=Badge_Grade_Settings)
![Build Status](https://app.bitrise.io/app/527234c879c3952a.svg?token=RCLpb4OfkyZcufMQ7bVCTQ)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/MoveUpwards/Sejima/blob/master/LICENSE)
[![GitHub contributors](https://img.shields.io/github/contributors/MoveUpwards/Sejima.svg)](https://github.com/MoveUpwards/Sejima/graphs/contributors)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://paypal.me/moveupwards)

## Why Sejima

Because in modern mobile applications, you often reuse user interface components. To avoid code duplication, we have tried to provide you with global standard user interface components.

Although Apple has introduce `@IBInspectable` properties to help define components directly in storyboard files.

All `Sejima` components expose its components properties using `@IBInspectable` so you can define user interface directly in your `.xib`/`.storyboard` files or using `UIAppearance`.

## Requirements

- iOS 9.1+
- Xcode 9.0+

## Installation

### use [CocoaPods](https://cocoapods.org) with Podfile

```swift
pod 'Sejima'
```

open your favorite terminal, go to your project root path:

```shell
pod install
```

### use [Carthage](https://github.com/Carthage/Carthage) with Cartfile

```shell
github "MoveUpwards/Sejima"
```

open your favorite terminal, go to your project root path and run:

```shell
carthage update
```

## Components

![Sketch template](./Screenshots/Sketch.png)

## Features

You can open the sketch template file provided with the source code to have a look at all the components.

- [**MUHeader:**](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/Examples/MUHeader.md) Component that define a title and a detail description.

- **MUTopBar:** Component that define a title and a button on left side.

- **MUButton:** UIButton with more customizable options.

- **MUHorizontalPager:** UIScrollView + isPagingEnabled with more customizable options.

- **MUPageControl:** UIPageControl with more customizable options.

- **MUTextField:** UITextField with more customizable options.

- **MUNavigationBar:** Component that define a left button along with a main button with a separator.

- **MUAvatar:** UIImage with possible design round, square or custom.

- **MUPinCode:** Component to handle pin code usage with possibly being alpha-numeric, emoji, numeric.

- **MUSegmentedControl:** UISegmentedControl like with more designable options.

- **MUProportionalBar:** An horizontal progress bar with multiple sections.

- **MUTrimmer:** A draggable component usually used to trim vidéo.

- **MUToast:** A toast message component.

- **MURadarGraph:** A spider graph to visualize multiple charts.

- **MUCircularProgress:** A circular progress with customizable options.
  
- **MUCard:** A card with Title and Subtitle and content view.
  
- **MUCollectionButton:** A group of UIButton with customizable options.

## Example

### Walkthrough

[Read the Medium article on how to build this Walkthrough](https://medium.com/@loic_19820/ios-tutorial-create-a-complete-walkthrough-3cac16112010)

1. MUHeader
2. MUPageControl
3. MUButton
4. MUHorizontalPager

![Walkthrough](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/Screenshots/Walkthrough.png)

### Login

1. MUTopBar
2. MUTextField
3. MUButton

![Login](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/Screenshots/Login.png)

## Sketch template

To help you design applications using Sejima components in [Sketch](https://sketchapp.com/) we provide a Sketch template with all our components available in Symbols.

[Sketch template](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/Sejima.sketch)

## Contributing

Please read our [Contributing Guide](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/CONTRIBUTING.md) before submitting a Pull Request to the project.

## Support

For more information on the upcoming version, please take a look to our [ROADMAP](https://github.com/MoveUpwards/Sejima/projects/).

#### Community support

For general help using Strapi, please refer to [the official Sejima documentation](https://moveupwards.github.io/Sejima/). For additional help, you can use one of this channel to ask question:

- [StackOverflow](http://stackoverflow.com/questions/tagged/sejima)
- [Slack](http://moveupwards.slack.com) (highly recommended for faster support)
- [GitHub](https://github.com/MoveUpwards/Sejima).

#### Professional support

We provide a full range of solutions to get better and faster results. We're always looking for the next challenge: consulting, training, develop mobile and web solution, etc.

[Drop us an email](mailto:contact@moveupwards.dev) to see how we can help you.

## License

Folding cell is released under the MIT license.
See [LICENSE](https://raw.githubusercontent.com/MoveUpwards/Sejima/master/LICENSE) for details.

If you use the open-source library in your project, please make sure to credit and backlink to www.moveupwards.dev
