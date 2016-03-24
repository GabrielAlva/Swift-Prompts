![License](https://img.shields.io/badge/Language-Swift-brightgreen.svg?style=flat)
[![Pod Version](http://img.shields.io/cocoapods/v/Swift-Prompts.svg?style=flat)](http://cocoadocs.org/docsets/Swift-Prompts/)
[![Pod Platform](http://img.shields.io/cocoapods/p/Swift-Prompts.svg?style=flat)](http://cocoadocs.org/docsets/Swift-Prompts/)
[![Pod License](http://img.shields.io/cocoapods/l/Swift-Prompts.svg?style=flat)](http://opensource.org/licenses/MIT)

![Swift Prompts.](https://raw.githubusercontent.com/GabrielAlva/Swift-Prompts/master/MarkdownImage.png)
<br />
<br />

## Installation
### CocoaPods

Install with [CocoaPods](http://cocoapods.org) by adding the following to your Podfile:

``` ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

use_frameworks!

pod 'Swift-Prompts', '~> 1.0.0'
```

**Note**: We follow http://semver.org for versioning the public API.

### Carthage

Using [Carthage](https://github.com/Carthage/Carthage):

```
github "GabrielAlva/Swift-Prompts"
```

### Manually
* Just include the three .swift files found on the `Swift Prompts` folder on the demo Xcode project.

## Usage 

Using **Swift Prompts** is very simple and fast.

### Adopting the prompt's delegate

In your class declaration, after specifying the type of class write `SwiftPromptsProtocol` as shown here:
```swift
class ViewController: UIViewController,  SwiftPromptsProtocol
```

Now, depending on the type of prompt, you can use any of the optional delegate functions

```swift
func clickedOnTheMainButton() {}
func clickedOnTheSecondButton() {}
func promptWasDismissed() {}
```

### Displaying a prompt

First you need to declare a var outside of a function:
```swift
var prompt = SwiftPromptsView()
```

Next, where you would like to trigger the prompt (e.g. in the action function of a button):

```swift
prompt = SwiftPromptsView(frame: self.view.bounds)
prompt.delegate = self

//Customization

self.view.addSubview(prompt)
```

### Dismissing a prompt

To dismiss the prompt, you can write this line in one of the delegate functions or in a different one:
```swift
prompt.dismissPrompt()
```
Alternatively, the dismissal by gesture is enabled by default so you can dismiss a prompt by moving it up or down until it dims completely. Dismissal by gesture will trigger the `promptWasDismissed()` delegate function.

##Customization

Once you have your assigned the frame and delegate, you can customize the look and feel of your prompt and its background. You can customize almost every aspect of it as shown above including the width and height. The demo app is well documented for you to use any function of the customization API. To see the full list you can navigate to the `SwiftPromptsView` class and look for the API pragma mark. 

##Example

You can find a full example on usage and customization on the Xcode project attached to this repository.

## License

Source code of this project is available under the standard MIT license. 
Please have a look at [the license file](LICENSE.md).
