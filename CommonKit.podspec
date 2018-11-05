Pod::Spec.new do |s|
  s.name             = 'CommonKit'
  s.version          = '1.6.18'
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
 - Merged: MathKit support. Math extensions are now merged to CommonKit.
 - Merged: DateKit support. Extension to Date and general helpers to handle dates in UTC timezone.
 - Merged: DispatchKit. Extensions to DispatchQueue and a simple but powerful backgrounding Task Manager support.
 - Merged: CurrencyKit. Framework helps presenting money.
 - Merged: AttributedStringWrapper by gaoyu/loopeer. I didn't write this, but it's great work, and I didn't want to add it is a dependency.
 - Merged: FontKit. Framework provides support for icon fonts. First one with FontAwesome 5 support :)
 - Merged: PopOverKit. Framework provides support for displaying popover balloons on iPhone and iPad.
 - Merged: PhotoPicker and PhotoPreview
                       DESC
 
  s.homepage         = 'https://github.com/oskarirauta/CommonKit'
  s.author           = { 'Oskari Rauta' => 'oskari.rauta@gmail.com' }
  s.source           = { :git => 'https://github.com/oskarirauta/CommonKit.git', :tag => s.version.to_s }

  s.screenshots      = [
			'https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Decimal.png',
			'https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Phone.png',
			'https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Landscape.png',
			'https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/Currency.png',
			'https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/FontKit.png',
			'https://raw.githubusercontent.com/oskarirauta/CommonKit/master/Screenshots/PhotoPicker.png'
		]

  s.swift_version = '4.2' 
  s.ios.deployment_target = '11.4'
  s.source_files = [
			'CommonKit/BarCode/Types/*.swift',
			'CommonKit/BarCode/Extensions/*.swift',
			'CommonKit/QRCode/Types/*.swift',
			'CommonKit/QRCode/Extensions/*.swift',
			'CommonKit/TableViewKit/Protocols/*.swift',
			'CommonKit/TableViewKit/Types/*.swift',
			'CommonKit/TableViewKit/Extensions/*.swift',
			'CommonKit/TableViewKit/Classes/*.swift',
			'CommonKit/PhotoPreview/Classes/*.swift',
			'CommonKit/PhotoPicker/Classes/*.swift',
			'CommonKit/PhotoPicker/Cells/*.swift',
			'CommonKit/PhotoPicker/Views/*.swift',
			'CommonKit/PhotoPicker/Datasource/*.swift',
			'CommonKit/AlertController/Types/*.swift',
			'CommonKit/AlertController/Protocols/*.swift',
			'CommonKit/AlertController/Templates/*.swift',
			'CommonKit/AlertController/Classes/*.swift',
			'CommonKit/PopOverKit/Protocols/*.swift',
			'CommonKit/PopOverKit/Extensions/*.swift',
			'CommonKit/PopOverKit/Classes/*.swift',
			'CommonKit/FontKit/Types/*.swift',
			'CommonKit/FontKit/Extensions/*.swift',
			'CommonKit/FontKit/Classes/*.swift',
			'CommonKit/FontKit/UI/*.swift',
			'CommonKit/FontKit/FontAwesome/*.swift',
			'CommonKit/FontKit/MaterialIcons/*.swift',
			'CommonKit/FontKit/FoundationIcons/*.swift',
			'CommonKit/AttributedStringWrapper/*.swift',
			'CommonKit/Currency/Protocols/*.swift',
			'CommonKit/Currency/Types/*.swift',
			'CommonKit/Currency/Extensions/*.swift',
			'CommonKit/Currency/Classes/*.swift',
			'CommonKit/Dispatch/Protocols/*.swift',
			'CommonKit/Dispatch/Extensions/*.swift',
			'CommonKit/Dispatch/Classes/*.swift',
			'CommonKit/Date/Types/*.swift',
			'CommonKit/Date/Extensions/*.swift',
			'CommonKit/Date/Classes/*.swift',
			'CommonKit/Date/Functions/*.swift',
			'CommonKit/Math/Extensions/*.swift',
			'CommonKit/AppLocale/Protocols/*.swift',
			'CommonKit/AppLocale/Types/*.swift',
			'CommonKit/AppLocale/Extensions/*.swift',
			'CommonKit/AppLocale/Functions/*.swift',
			'CommonKit/NumPad/Types/*.swift',
			'CommonKit/NumPad/Classes/*.swift',
			'CommonKit/CommonKit/Protocols/*.swift',
			'CommonKit/CommonKit/Extensions/*.swift',
			'CommonKit/CommonKit/Types/*.swift',
			'CommonKit/CommonKit/Classes/*.swift',
			'CommonKit/CommonKit/Functions/*.swift'
		]

  s.resources = [
		'CommonKit/FontKit/Resources/*.otf',
		'CommonKit/FontKit/Resources/*.ttf',
		'CommonKit/NumPad/Resources/NumPad.xcassets',
		'CommonKit/Currency/Resources/CurrencyKit.xcassets',
		'CommonKit/TableViewKit/Resources/TVKIT.xcassets',
		'CommonKit/PhotoPicker/Resources/UIPhotoPicker.xcassets'
		]
 
end
