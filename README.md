# CommonKit
A Swift framework with some common extensions and functions

### Contents
Various extensions and functions. Some are written by me, some are collected online. And some are variations.
This framework is supposed to give you a faster start with your project by combining some useful and often used code. Includes few UI classes extending UILabel as well since extensions for UILabel could not provide this functionality.

This framework is base for some other frameworks I provide, whilst as alone, it doesn't offer that much.

### AppLocale
LocaleKit framework was merged with CommonKit since release 1.2.3.
LocaleKit allows App wide fixed locale to be defined and also provides some extended functionality to Locale as well while providing some simple data formatting options.

### NumPad
My NumPad framework was merged with CommonKit since release 1.2.4.
NumPad is a numeric keyboard (with some styling options, for example, phone style) which works on both, iPhone and iPad. Also provided is a DoneBar, ready accessory view with Done button for keyboards without Enter button.
Example is provided.

### MathKit
MathKit framework was merged with CommonKit since release 1.2.6.

# NumPad class
NumPad class provides a NumPad style keyboard for iOS platforms with some styling properties.
Class can have type set to one of following types:
  - number: Simple digit input
  - decimal: Decimal number input (adds decimal point button)
  - phone: Phone number input ( adds + button and changes appearance of buttons in portrait mode )
  
# NumPad Styling
NumPad can be styled with following attributes:
  - overlayColor ( view background )
  - backgroundColor ( button background )
  - backgroundColorHighlighted ( button background when highlighted )
  - shadowColor ( button shadow color )
  - foregroundColor ( button text color )
  - foregroundColorHighlighted ( button text color when highlighted )
  - font ( font for numbers and +/. buttons )
  - phoneFont ( button font when using phone type )
  - phoneCharFont ( when phone type is used, this font is used for letters )
  - backspaceColor ( color of backspace icon )

# DoneBar class
Donebar is a fast UIToolbar initializer with Done button aligned to right.

# Usage
Used with UITextField or UITextView.

```
var tf: UITextField = UITextField(frame: .zero)
...
tf.inputView = NumPad(type: .number)
tf.inputAccessoryView = DoneBar()
```

Steps:
  - Download this repository
  - On your own workspace, add NumPad.xcodeproj to it
  - On your own project ( in workspace ), add NumPad to it's frameworks.
  - add import NumPad to files where you need NumPad.

See provided example.

# Screenshots

![Screenshot of decimal keyboard](https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Decimal.png)   ![Screenshot of phone keyboard](https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Phone.png)

![Landscape screenshot](https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Landscape.png)

### Examples
Examples come with Podfiles, so go to examples root directory and execute ```pod install``` to enable compilation.

### CocoaPods
CommonKit is now available through CocoaPods.
Here's a sample Podfile:
```
source 'https://github.com/CocoaPods/Specs.git'

# inhibit_all_warnings!
use_frameworks!

platform :ios, '11.0'

target 'YOURPROJECT' do
        pod 'CommonKit', git: 'https://github.com/oskarirauta/CommonKit.git'
end
```
