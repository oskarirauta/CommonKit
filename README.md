# CommonKit
A Swift framework with some common extensions and functions

### Contents
Various extensions and functions. Some are written by me, some are collected online. And some are variations.
This framework is supposed to give you a faster start with your project by combining some useful and often used code. Includes few UI classes extending UILabel as well since extensions for UILabel could not provide this functionality.

This framework is base for some other frameworks I provide, whilst as alone, it doesn't offer that much.

### LocaleKit
My LocaleKit framework has been merged with CommonKit since release 1.2.3.
LocaleKit allows App wide fixed locale to be defined and also provides some extended functionality to Locale as well while providing some simple data formatting options.

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
