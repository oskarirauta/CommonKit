Pod::Spec.new do |s|
  s.name             = 'CommonKit'
  s.version          = '1.2.4'
  s.license          = { :type => 'Free', :text => 'Free' }
  s.summary          = 'A Swift framework with some common extensions and functions'
 
  s.description      = <<-DESC
Various extensions and functions. Some are written by me, some are
collected online. And some are variations. This framework is supposed
to give you a faster start with your project by combining some useful
and often used code. Includes few UI classes extending UILabel as well
since extensions for UILabel could not provide this functionality.

 - Merged: LocaleKit support. LocaleKit allows a fixed App wide locale to be defined.
 - Merged: NumPad. NumPad for both iPhone and iPad, also with phone style keypad.
                       DESC
 
  s.homepage         = 'https://github.com/oskarirauta/CommonKit'
  s.author           = { 'Oskari Rauta' => 'oskari.rauta@gmail.com' }
  s.source           = { :git => 'https://github.com/oskarirauta/CommonKit.git', :tag => s.version.to_s }

  s.swift_version = '4.0' 
  s.ios.deployment_target = '11.0'
  s.source_files = 'CommonKit/CommonKit/Protocols/*.swift', 'CommonKit/CommonKit/Extensions/*.swift', 'CommonKit/CommonKit/Types/*.swift', 'CommonKit/CommonKit/Classes/*.swift', 'CommonKit/CommonKit/Functions/*.swift'
  s.resources = [ 'CommonKit/CommonKit/Resources/NumPad.xcassets' ]
 
end
