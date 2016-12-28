//
//  UIViewExtension.swift
//  drivers
//
//  Created by Đinh Anh Huy on 10/10/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

extension UIView {
    //MARK: Layer
    func makeRoundedConner(radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func copyView() -> UIView {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! UIView
    }
}

//MARK: Indicator
extension UIView {
    func showIndicator(indicatorStyle: UIActivityIndicatorViewStyle, blockColor: UIColor, alpha: CGFloat) {
        OperationQueue.main.addOperation {
            
            for currentView in self.subviews {
                if currentView.tag == 9999 {
                    return
                }
            }
            
            let viewBlock = UIView()
            viewBlock.tag = 9999
            viewBlock.backgroundColor = blockColor
            viewBlock.alpha = alpha
            
            viewBlock.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(viewBlock)
            _ = viewBlock.addConstraintFillInView(view: self, commenParrentView: self)
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: indicatorStyle)
            
            indicator.frame = CGRect(
                x: self.frame.width/2-25,
                y: self.frame.height/2-25,
                width: 50,
                height: 50)
            
            viewBlock.addSubview(indicator)
            
            
            indicator.startAnimating()
        }
    }
    
    func showIndicator() {
        OperationQueue.main.addOperation {
            
            for currentView in self.subviews {
                if currentView.tag == 9999 {
                    return
                }
            }
            
            let viewBlock = UIView()
            viewBlock.tag = 9999
            viewBlock.backgroundColor = UIColor.black
            viewBlock.alpha = 0.3
            
            viewBlock.layer.cornerRadius = self.layer.cornerRadius
            
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
            
            viewBlock.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(viewBlock)
            _ = viewBlock.addConstraintFillInView(view: self, commenParrentView: self)
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
            viewBlock.addSubview(indicator)
            _ = indicator.addConstraintCenterXToView(view: self, commonParrentView: self)
            _ = indicator.addConstraintCenterYToView(view: self, commonParrentView: self)
            
            indicator.startAnimating()
        }
    }
    
    func showIndicator(frame: CGRect, blackStyle: Bool = false) {
        let viewBlock = UIView()
        viewBlock.tag = 9999
        viewBlock.backgroundColor = UIColor.white
        viewBlock.frame = frame
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        indicator.frame = CGRect(
            x: self.frame.width/2-25,
            y: self.frame.height/2-25,
            width: 50,
            height: 50)
        
        viewBlock.addSubview(indicator)
        self.addSubview(viewBlock)
        
        indicator.startAnimating()
    }
    
    func hideIndicator() {
        
        let indicatorView = self.viewWithTag(9999)
        indicatorView?.removeFromSuperview()
        
        for currentView in self.subviews {
            if currentView.tag == 9999 {
                let _view = currentView
                OperationQueue.main.addOperation {
                    _view.removeFromSuperview()
                }
            }
        }
    }
}

//MARK: Animation
extension UIView {
    func moveToFrameWithAnimation(newFrame: CGRect, delay: TimeInterval, time: TimeInterval) {
        
        UIView.animate(withDuration: time, delay: delay, options: .curveEaseOut, animations: {
            self.frame = newFrame
            }, completion:nil)
    }
    
    func fadeOut(time: TimeInterval, delay: TimeInterval) {
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: time, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                if finished == true {
                    self.isHidden = true
                }
        })
    }
    
    func fadeIn(time: TimeInterval, delay: TimeInterval) {
        
        self.isUserInteractionEnabled = true
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: time, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: {
                (finished: Bool) -> Void in
                if finished == true {
                    
                }
        })
    }
}

//MARK: Add constraint
extension UIView {
    func leadingMarginToView(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint  {
        let constraint = NSLayoutConstraint(
            item: self, attribute: .leading, relatedBy: .equal,
            toItem: view, attribute: .leading, multiplier: 1, constant: margin)
        
        commonParrentView.addConstraint(constraint)
        
        return constraint
    }
    
    func trailingMarginToView(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self, attribute: .trailing, relatedBy: .equal,
            toItem: view, attribute: .trailing, multiplier: 1, constant: margin)
        
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintTopToBot(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .top, relatedBy: .equal,
            toItem: view, attribute: .bottom, multiplier: 1, constant: margin)
        
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintBotToTop(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .bottom, relatedBy: .equal,
            toItem: view, attribute: .top, multiplier: 1, constant: margin)
        
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintBotMarginToView(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: self, attribute: .bottom, relatedBy: .equal,
            toItem: view, attribute: .bottom, multiplier: 1, constant: margin)
        
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintTopMarginToView(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        //        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let constraint = NSLayoutConstraint(
            item: self, attribute: .top, relatedBy: .equal,
            toItem: view, attribute: .top, multiplier: 1, constant: margin)
        
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    
    func addConstraintWidth(parrentView: UIView, width: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.width,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: nil,
                                             attribute: NSLayoutAttribute.notAnAttribute,
                                             multiplier: 1,
                                             constant: width)
        parrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintHeight(parrentView: UIView, height: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.height,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: nil,
                                             attribute: NSLayoutAttribute.notAnAttribute,
                                             multiplier: 1,
                                             constant: height)
        parrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintLeftToRight(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.left,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: view,
                                             attribute: NSLayoutAttribute.right,
                                             multiplier: 1,
                                             constant: margin)
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintRightToLeft(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.right,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: view,
                                             attribute: NSLayoutAttribute.left,
                                             multiplier: 1,
                                             constant: margin)
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintCenterYToView(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.centerY,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: view,
                                             attribute: NSLayoutAttribute.centerY,
                                             multiplier: 1,
                                             constant: 0) //hardcode
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintCenterXToView(view: UIView, commonParrentView: UIView, margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.centerX,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: view,
                                             attribute: NSLayoutAttribute.centerX,
                                             multiplier: 1,
                                             constant: margin)    //hardcode
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintEqualHeightToView(view: UIView, commonParrentView: UIView,
                                        margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.height,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: view,
                                             attribute: NSLayoutAttribute.height,
                                             multiplier: 1,
                                             constant: margin)    //hardcode
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintEqualWidthToView(view: UIView, commonParrentView: UIView,
                                       margin: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint (item: self,
                                             attribute: NSLayoutAttribute.width,
                                             relatedBy: NSLayoutRelation.equal,
                                             toItem: view,
                                             attribute: NSLayoutAttribute.width,
                                             multiplier: 1,
                                             constant: margin)    //hardcode
        commonParrentView.addConstraint(constraint)
        return constraint
    }
    
    func addConstraintFillInView(view: UIView,
                                 commenParrentView: UIView,
                                 margins: [CGFloat]? = nil) ->
                                (top: NSLayoutConstraint, bot: NSLayoutConstraint,
                                lead: NSLayoutConstraint, trail: NSLayoutConstraint) {
            var mutableMargins = margins
            if mutableMargins == nil { mutableMargins = [0, 0, 0, 0] }
            
            let top = addConstraintTopMarginToView(view: view,
                                                   commonParrentView: commenParrentView,
                                                   margin: mutableMargins![0])
            let trail = trailingMarginToView(view: view,
                                             commonParrentView: commenParrentView,
                                             margin: mutableMargins![1])
            let bot = addConstraintBotMarginToView(view: view,
                                                   commonParrentView: commenParrentView,
                                                   margin: mutableMargins![2])
            let lead = leadingMarginToView(view: view,
                                           commonParrentView: commenParrentView,
                                           margin: mutableMargins![3])
            return (top, bot, lead, trail)
    }
}

//MARK: Get constraint from superview
extension UIView {
    func constraintTop() -> NSLayoutConstraint? {
        guard let parrentView = superview else { return nil }
        for constraint in parrentView.constraints {
            guard constraint.isConstraintOfView(view: self) else { continue }
            guard constraint.isTopConstraint() else { continue }
            return constraint
        }
        return nil
    }
    
    func constraintBot() -> NSLayoutConstraint? {
        guard let parrentView = superview else { return nil }
        for constraint in parrentView.constraints {
            guard constraint.isConstraintOfView(view: self) else { continue }
            guard constraint.isBotConstraint() else { continue }
            return constraint
        }
        return nil
    }
    
    func constraintLead() -> NSLayoutConstraint? {
        guard let parrentView = superview else { return nil }
        for constraint in parrentView.constraints {
            guard constraint.isConstraintOfView(view: self) else { continue }
            guard constraint.isLeadConstraint() else { continue }
            return constraint
        }
        return nil
    }
    
    func constraintTrail() -> NSLayoutConstraint? {
        guard let parrentView = superview else { return nil }
        for constraint in parrentView.constraints {
            guard constraint.isConstraintOfView(view: self) else { continue }
            guard constraint.isTrailConstraint() else { continue }
            return constraint
        }
        return nil
    }
}
