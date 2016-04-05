//
//  Extensioner.swift
//  Randomizer
//
//  Created by Max Chuquimia on 5/04/2016.
//  Copyright © 2016 Chuquimian Productions. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func hide() {
        alpha = 0.0
    }
    
    func show() {
        alpha = 1.0
    }
}

extension NSUserDefaults {
    class func setHue(h: CGFloat) {
        NSUserDefaults.standardUserDefaults().setObject(NSNumber(float: Float(h)), forKey: "Randomizer-HueKey")
        NSUserDefaults.standardUserDefaults().synchronize() //let's me safe, I mean, what if it crashes before this happens!
    }
    
    class func getHue() -> CGFloat {
        guard let v = NSUserDefaults.standardUserDefaults().objectForKey("Randomizer-HueKey") as? NSNumber else {
            return 0.57
        }
        
        return CGFloat(v.floatValue)
    }
}

extension UIColor {
    class func withHue(h: CGFloat) -> UIColor {
        return UIColor(hue: h, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
}
