//
//  SegmentedControlExtension.swift
//  Demo
//
//  Created by Tien Dat on 10/24/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import Foundation
import UIKit
extension UISegmentedControl {
func removeBorders() {
//    setBackgroundImage(self.imageWithColor(UIColor.clearColor()), forState: .Normal, barMetrics: .Default)
    setBackgroundImage(imageWithColor(tintColor!), for: .selected, barMetrics: .default)
    setDividerImage(imageWithColor(UIColor.clear), forLeftSegmentState: UIControlState(), rightSegmentState: UIControlState(), barMetrics: .default)
    
    for  borderview in subviews {
        
        let upperBorder: CALayer = CALayer()
        upperBorder.backgroundColor = UIColor.init(red: 215/255.0, green: 0.0, blue: 30/255.0, alpha: 1.0).cgColor
        upperBorder.frame = CGRect(x: 0, y: borderview.frame.size.height-1, width: borderview.frame.size.width, height: 1.0)
        borderview.layer .addSublayer(upperBorder)
        
        borderview.layer.allowsEdgeAntialiasing = true
        
        borderview.layer.shadowOffset = CGSize.init(width: 10, height: 10)
        
       
        borderview.layer.cornerRadius = CGFloat(5)
        borderview.layer.masksToBounds = true
        //            borderview.frame = CGRectMake(0, borderview.frame.size.height-1, borderview.frame.size.width, 1.0)
        
        
    }

}

// create a 1x1 image with this color
fileprivate func imageWithColor(_ color: UIColor) -> UIImage {
    let rect = CGRect(x: 0.0, y: 0.0, width: 0.5, height: 0.5)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor);
    context?.fill(rect);
    let image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image!
}

}
