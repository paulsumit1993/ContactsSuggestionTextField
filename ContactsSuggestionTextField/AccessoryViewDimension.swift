//
//  Extensions.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import Foundation

struct AccessoryViewDimension {
    
    private init() {}
    
    /// determines the height of the accessory view
    static var height: CGFloat {
        return UIDevice().userInterfaceIdiom == .phone ? 50 : 60
    }
    
    /// determines the width of the accessory view - the width of the screen
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// computed frame from the properties above
    static var frame: CGRect {
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}
