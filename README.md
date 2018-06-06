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

### DateKit
DateKit framework was merged with CommonKit since release 1.2.7.
DateKit contains various Date extensions and general helpers for handling date and time in UTC format.

### DispatchKit
DispatchKit framework was merged with CommonKit since release 1.2.7.
DispatchKit contains extensions to DispatchQueue and a simple backgrounding task management.
Example code included.

### CurrencyKit
CurrencyKit framework was merger with CommonKit since release 1.2.9.
CurrencyKit is a money presentation framework for Swift.

### NumPad class
NumPad class provides a NumPad style keyboard for iOS platforms with some styling properties.
Class can have type set to one of following types:
  - number: Simple digit input
  - decimal: Decimal number input (adds decimal point button)
  - phone: Phone number input ( adds + button and changes appearance of buttons in portrait mode )
  
### NumPad Styling
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

### DoneBar class
Donebar is a fast UIToolbar initializer with Done button aligned to right.

### NumPad Screenshots

![Screenshot of decimal keyboard](https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Decimal.png)   ![Screenshot of phone keyboard](https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Phone.png)

![Landscape screenshot](https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Landscape.png)

### Usage
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

### Currency
Can be used for:
 - Money calculations with currencies which have cents/pennies/etc with 2 digits.
 - Presentation of Money value with locale.
 - Contains a UI element based on textfield which allows entering a monetary value.
 - Provides also a structure for item with price information.
 - Array of items as cart.
 - VAT calculation included for item prices.

What it doesn't have:
 - Support switching currencies/currency rates (100USD = 100EUR = 100GBP, rate does not change)
 - Support for Apple Pay or similar services

### If I need more?
Check Daniel Thorpe's Money: https://github.com/danthorpe/Money

### Screenshot (from provided sample)
![CurrencyKit](https://github.com/oskarirauta/CommonKit/raw/master/Screenshots/Currency.png)

### What keyboard is in the picture?
It is CurrencyPad provided by this framework. Works on both, iPad and iPhone.

### Keyboard works a bit like a calculator, could I get cursor and make it work by standard keyboard or get it a bit less bulky?
Sure you can, but then you will need to implement this by on your own. I am happy with it's current implementation at the moment.

### What type of storage is used for storing money value?
I used Decimal. And Money struct conforms to Codable.

### Can I sum different Money structs?
Yes. Money(10.0) + Money(20.0) = Money(30.0)

### Is VAT supported?
Yes, in Cart/CartItem. Money is always money, so it doesn't care about if one part of it is used for taxes or something.
With VAT, you can get amount of VAT for sum, VAT0 sum, and sum with VAT multiplied by amount of items. And ofcourse, used VAT percentage of CartItem.

### What else is in CartItem besides price?
Item name and amount.

### Is it precise?
I have done my best to provide precise values. VAT percentage has support for 1 decimal and Money has support for 2 decimals.

### Can I see some tests?
Here is a list output from sample app:
```
Item1	| 15,00 €	| 1		  |  0%	| 0,00 €	| 15,00 €	| 15,00 €
Item2	| 10,00 €	| 1		  | 24%	| 2,40 €	| 10,00 €	| 12,40 €
Item3	| 15,00 €	| 2pcs	          | 24%	| 7,20 €	| 30,00 €	| 37,20 €
Item4	| 20,00 €	| 0		  |  0% | 0,00 €	|  0,00 €	|  0,00 €
Item5	| 9,00  €	| 0		  | 24%	| 0,00 €	|  0,00 €	|  0,00 €
									  									           9,60 €	| 55,00 €	| 64,60 €
```

It's built like this:
```
        var cart: Cart = Cart()
        cart.append(CartItem(name: "Item1", price: 15.0))
        cart.append(CartItem(name: "Item2", price: 10.0, VAT: 24.0))
        cart.append(CartItem(name: "Item3", count: 2, unit: "pcs", price: 15.0, VAT: 24.0))
        cart.append(CartItem(name: "Item4", count: 0, price: 20.0))
        cart.append(CartItem(name: "Item5", count: 0, price: 9.0, VAT: 24.0))
```

### Examples
Examples come with Podfiles, so go to examples root directory and execute ```pod install``` to enable compilation.
Examples are provided for:
 - AppLocale
 - NumPad ( Depends on my version of PhoneNumberKit, check included Podfile for NumPad )
 - Dispatch: Utilizes included backgrounding task management, check console output.
 - Currency

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
