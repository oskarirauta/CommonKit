//
//  Font.swift
//
//  Created by Oskari Rauta on 19/04/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public enum Font: String, FontEnum {
    public static var fonts: [IconType.Type] { return [ FontAwesome.self, FontAwesome.regular.self, FontAwesome.brands.self, MaterialIcons.self ] }

    case fas = "0,fas,FontAwesome,solid,Font Awesome 5 Free,FontAwesome5FreeSolid,Font Awesome 5 Free-Solid-900,otf,7.80,1.00"
    case far = "1,far,FontAwesome,regular,Font Awesome 5 Free,FontAwesome5FreeRegular,Font Awesome 5 Free-Regular-400,otf,7.80,1.00"
    case fab = "2,fab,FontAwesome,brands,Font Awesome 5 Brands,FontAwesome5BrandsRegular,Font Awesome 5 Brands-Regular-400,otf,7.80,1.00"
    case mat = "3,mat,MaterialIcons,regular,Material Icons,MaterialIcons-Regular,MaterialIcons-Regular,ttf,1.00,1.00"
    case fi = "4,fi,fontcustom,regular,Foundation Icons,fontcustom,foundation-icons,ttf,1.00,1.00"
}
