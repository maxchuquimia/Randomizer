//
//  RainbowViewer.swift
//  Randomizer
//
//  Created by Max Chuquimia on 5/04/2016.
//  Copyright © 2016 Chuquimian Productions. All rights reserved.
//

import Foundation
import UIKit

class RainbowViewer: UIView {
 
    var colorChanged: ((UIColor, CGFloat) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let image = UIImage.rainbow(CGSizeMake(700, 150))
        let imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleToFill
        imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        imageView.frame = bounds
        addSubview(imageView)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        touched(touches.first)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        touched(touches.first)
    }
    
    private func touched(t: UITouch?) {
        guard let p = t?.locationInView(self) else { return }
        calculate(p)
    }
    
    private func calculate(p: CGPoint) {
        
        guard let colorChanged = colorChanged else { return }
        let h = p.x / bounds.width
        let color = UIColor.withHue(h)
        colorChanged(color, h)
    }
}