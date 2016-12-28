//
//  TextViewExtension.swift
//  Demo
//
//  Created by Tien Dat on 10/25/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import Foundation
import UIKit
extension UITextView {
    func scrollToBotom() {
        let range = NSMakeRange((text as NSString).length - 1, 1);
        scrollRangeToVisible(range);
    }
    func scrollToTop() {
        let range = NSMakeRange(0, 0);
        scrollRangeToVisible(range);
    }
}
