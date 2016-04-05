//
//  ViewController.swift
//  Randomizer
//
//  Created by Max Chuquimia on 5/04/2016.
//  Copyright © 2016 Chuquimian Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //cache these for speed later
    var images: [UIImage] = []
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var settingsHeight: NSLayoutConstraint!
    @IBOutlet weak var settingsBottom: NSLayoutConstraint!
    
    @IBOutlet weak var settingsView: RainbowViewer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage.arrow(CGSizeMake(1000, 600))
        
        guard let cgImage = image.CGImage else {
            return //OMG don't crash!
        }
        
        let reversedImage =  UIImage(CGImage: cgImage, scale: 1.0, orientation: .UpMirrored)
        images = [image, reversedImage]
        
        settingsView.colorChanged = colorChanged
        
        colorChanged(.withHue(NSUserDefaults.getHue()))
    }
    
    func colorChanged(c: UIColor, h: CGFloat? = nil) {
        view.backgroundColor = c
        
        guard let h = h else { return }
        NSUserDefaults.setHue(h)
    }

    var isLoadingImage = false
    func loadImage(image: UIImage) {
        isLoadingImage = true
        imageView.image = image

        UIView.animateWithDuration(0.3, delay: 0.0, options: [.CurveLinear], animations: imageView.show) { _ in
            UIView.animateWithDuration(0.3, delay: 2.0, options: [.CurveLinear], animations: self.imageView.hide) { _ in
                self.isLoadingImage = false
            }
        }
    }
    
    @IBAction func viewTapped(sender: UITapGestureRecognizer) {
        
        if self.labels.first?.alpha == 1.0 {
            UIView.animateWithDuration(0.1) {
                self.labels.forEach({$0.hide()})
                self.hintLabel.show()
            }
        }
        
        if settingsBottom.constant == 0.0 {
            settingsBottom.constant = -settingsHeight.constant
            UIView.animateWithDuration(0.3, animations: view.layoutIfNeeded)
        }
        
        guard !isLoadingImage else {
            return
        }
        
        let item = Randomizer.zeroOrOne()
        
        guard item < images.count else {
            return //We need extra safety to be sure that this never crashes
        }
        
        loadImage(images[item])
    }

    @IBAction func viewDoubleTapped(sender: UITapGestureRecognizer) {
        settingsBottom.constant = 0.0
    
        UIView.animateWithDuration(0.3, animations: view.layoutIfNeeded)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        let point = gestureRecognizer.locationOfTouch(0, inView: view)
        return !CGRectContainsPoint(settingsView.frame, point)
    }
}
