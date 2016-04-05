//
//  Renderer.swift
//  Randomizer
//
//  Created by Max Chuquimia on 5/04/2016.
//  Copyright © 2016 Chuquimian Productions. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func arrow(size: CGSize) -> UIImage {
        
        func multiply(p: CGPoint) -> CGPoint {
            return CGPointMake(p.x * size.width, p.y * size.height)
        }
        
        /*
         * ➡︎
         */
        let pointIn1x1 = [
            CGPointMake(0, 0.7),
            CGPointMake(0.65, 0.7),
            CGPointMake(0.65, 1.0),
            CGPointMake(1.0, 0.5),
            CGPointMake(0.65, 0),
            CGPointMake(0.65, 0.3),
            CGPointMake(0, 0.3),
        ]
        
        UIGraphicsBeginImageContext(size)
        
        let path = UIBezierPath()
        
        pointIn1x1
            .map(multiply)
            .enumerate()
            .forEach { (idx, p) in
            if idx == 0 {
                path.moveToPoint(p);
            }
            else {
                path.addLineToPoint(p)
            }
        }
        
        path.closePath()
        
        UIColor.whiteColor().setFill()
        path.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    class func rainbow(size: CGSize) -> UIImage {
        
        
        UIGraphicsBeginImageContext(size)
        let total = Int(size.width)
        (0...total).forEach { l in
            
            UIColor.withHue(CGFloat(l) / CGFloat(total)).setFill()
            UIBezierPath(rect: CGRectMake(CGFloat(l), 0, 1, size.height)).fill()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
}
