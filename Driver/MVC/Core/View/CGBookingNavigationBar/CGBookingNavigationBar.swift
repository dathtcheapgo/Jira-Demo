//
//  CGBookingNavigationBar.swift
//  Rider
//
//  Created by Đinh Anh Huy on 11/2/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

protocol CGBookingNavigationBarDelegate {
    func bookingNavigationBarDidChangeIndex(sender: CGBookingNavigationBar,
                                            title: String, index: Int)
}

class CGBookingNavigationBar: BaseXibView {
    
    let animateDuration: TimeInterval = Config.shareInstance.animateDuration/2
    
    @IBOutlet var view: UIView!
    @IBOutlet var viewWrapTitle: UIView!
    @IBOutlet var imgLeft: UIImageView!
    @IBOutlet var imgRight: UIImageView!
    
    var delegate: CGBookingNavigationBarDelegate?
    
    var titles = ["Passenger", "Delivery", "Tour", "Car Hire"]
    var lbTitles = [UILabel]()
    var viewForcus = UIView()
    var leadingConstraintViewForcus: NSLayoutConstraint!
    
    @IBAction func leftButtonDidClick(_ sender: UIButton) {
        
    }
    
    @IBAction func rightButtonDidClick(_ sender: UIButton) {
        
    }
    
    override func initControl() {
        //load nib file
        Bundle.main.loadNibNamed("CGBookingNavigationBar", owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        _ = view.addConstraintFillInView(view: self, commenParrentView: self)
        
        setupTitleLabel()
        setupViewForcus()
    }
}

//MARK: Show, Hide animation
extension CGBookingNavigationBar {
    func show() {
        self.constraintTop()?.constant = 0
        UIView.animate(withDuration: animateDuration, animations: {
            self.superview?.layoutIfNeeded()
        }) { (complete) in
            
        }
    }
    
    func hide() {
        self.constraintTop()?.constant = -frame.size.height
        UIView.animate(withDuration: animateDuration, animations: { 
            self.superview?.layoutIfNeeded()
        }) { (complete) in
            
        }
    }
}


//MARK: Setup UI
extension CGBookingNavigationBar {
    func setupTitleLabel() {
        //setup list title label UI and action
        for i in 0..<titles.count {
            let label = UILabel()
            label.setup()
            setupGestureForLabel(label: label)
            label.text = titles[i]
            label.translatesAutoresizingMaskIntoConstraints = false
            label.adjustsFontSizeToFitWidth = true
            
            viewWrapTitle.addSubview(label)
            _ = label.addConstraintTopMarginToView(view: viewWrapTitle,
                                                   commonParrentView: viewWrapTitle)
            _ = label.addConstraintBotMarginToView(view: viewWrapTitle,
                                                   commonParrentView: viewWrapTitle)
            if i == 0 {
                _ = label.leadingMarginToView(view: viewWrapTitle,
                                              commonParrentView: viewWrapTitle)
                label.textColor = UIColor.forcusColor()
            } else {
                _ = label.addConstraintLeftToRight(view: lbTitles.last!,
                                                   commonParrentView: viewWrapTitle)
                _ = label.addConstraintEqualWidthToView(view: lbTitles.last!,
                                                        commonParrentView: viewWrapTitle)
            }
            if i == titles.count - 1 {
                _ = label.trailingMarginToView(view: viewWrapTitle,
                                               commonParrentView: viewWrapTitle)
            }
            lbTitles.append(label)
        }
    }
    
    func setupViewForcus() {
        
        //setup UI
        viewForcus.layer.cornerRadius = 5
        viewForcus.clipsToBounds = true
        viewForcus.backgroundColor = UIColor.white
        
        //setup constraint
        let margin: CGFloat = 2
        viewForcus.translatesAutoresizingMaskIntoConstraints = false
        viewWrapTitle.insertSubview(viewForcus, at: 0)
        leadingConstraintViewForcus = viewForcus.leadingMarginToView(
            view: viewWrapTitle,
            commonParrentView: viewWrapTitle,
            margin: margin)
        _ = viewForcus.addConstraintTopMarginToView(
            view: viewWrapTitle,
            commonParrentView: viewWrapTitle,
            margin: margin)
        _ = viewForcus.addConstraintBotMarginToView(
            view: viewWrapTitle,
            commonParrentView: viewWrapTitle,
            margin: -margin)
        _ = viewForcus.addConstraintEqualWidthToView(view: lbTitles.first!,
                                                     commonParrentView: viewWrapTitle,
                                                     margin: -margin)
    }
    
    func setupGestureForLabel(label: UILabel) {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.labelDidClick(sender:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
    }
    
    func labelDidClick(sender: UIGestureRecognizer) {
        //move viewForcus to label position
        guard let label = sender.view as? UILabel else { return }
        let index = CGFloat(lbTitles.index(of: label)!)
        let width = viewWrapTitle.frame.width/4
        var constant = width * index
        if constant == 0 { constant += 2 }
        leadingConstraintViewForcus.constant = constant
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }) { (finish) in
            let convertIndex = Int(index)
            let title = self.titles[convertIndex]
            self.delegate?.bookingNavigationBarDidChangeIndex(sender: self,
                                                              title: title,
                                                              index: convertIndex)
        }
        _ = lbTitles.map { $0.textColor = UIColor.inforcusColor() }
        label.textColor = UIColor.forcusColor()
    }
}

fileprivate extension UILabel {
    func setup() {
        textColor = UIColor.white
        textAlignment = .center
        font = self.font.withSize(13)
    }
    
    func setStyle(isForcus: Bool) {
        if isForcus { textColor = UIColor.forcusColor() }
        else { textColor = UIColor.inforcusColor() }
    }
}

fileprivate extension UIColor {
    static func forcusColor() -> UIColor {
        return UIColor.RGB(red: 21, green: 180, blue: 241)
    }
    
    static func inforcusColor() -> UIColor {
        return UIColor.white
    }
}
