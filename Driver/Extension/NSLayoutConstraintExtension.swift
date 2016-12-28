//
//  NSLayoutConstraintExtension.swift
//  Rider
//
//  Created by Đinh Anh Huy on 11/3/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func isConstraintOfView(view: UIView) -> Bool {
        if firstItem as? UIView == view || secondItem as? UIView == view {
            return true
        }
        return false
    }
    
    func isTopConstraint() -> Bool {
        if firstAttribute == .top && secondAttribute == .top { return true }
        return false
    }
    
    func isBotConstraint() -> Bool {
        if firstAttribute == .bottom && secondAttribute == .bottom { return true }
        return false
    }
    
    
    func isLeadConstraint() -> Bool {
        if firstAttribute == .leading && secondAttribute == .leading { return true }
        return false
    }

    func isTrailConstraint() -> Bool {
        if firstAttribute == .trailing && secondAttribute == .trailing { return true }
        return false
    }
    
    func isVerticalConstraint() -> Bool {
        if (firstAttribute == .top && secondAttribute == .bottom) ||
            (firstAttribute == .bottom && secondAttribute == .top) {
            return true
        }
        return false
    }
    
    func isHorizonConstraint() -> Bool {
        if (firstAttribute == .leading && secondAttribute == .trailing) ||
            (firstAttribute == .trailing && secondAttribute == .leading) {
            return true
        }
        return false
    }
}
