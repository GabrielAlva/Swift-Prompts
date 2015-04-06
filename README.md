![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg?style=flat)
![License](https://img.shields.io/badge/Language-Swift-red.svg?style=flat)
![Level](https://img.shields.io/badge/License-MIT-blue.svg?style=flat)

![Swift Prompts.](https://raw.githubusercontent.com/GabrielAlva/Swift-Prompts/master/MarkdownImage.png)
<br />
<br />

## Installation
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

The MIT License (MIT)

**Copyright (c) 2015 Gabriel Alvarado (gabrielle.alva@gmail.com)**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
