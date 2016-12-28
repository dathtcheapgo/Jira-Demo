//
//  CGNavbar.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/19/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

protocol CGNavbarDelegate {
    func navbarDidClickBack(sender: CGNavbar)
}

class CGNavbar: HBorderView {

    @IBOutlet var view: UIView!
    @IBOutlet var lbTitle: UILabel!
    
    @IBInspectable var useBackButton: Bool = true
    @IBInspectable var title: String = "Countries"
    @IBInspectable var useCustomButton: Bool = false
    
    @IBAction func btBackDidClick(sender: UIButton) {
        delegate?.navbarDidClickBack(sender: self)
    }
    
    var delegate: CGNavbarDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initControl()
    }
    
    func initControl() {
        Bundle.main.loadNibNamed("CGNavbar", owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        _ = view.addConstraintFillInView(view: self, commenParrentView: self)
        
        gradientLeftColor = UIColor()
        gradientRightColor = UIColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.removeFromSuperlayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradient.colors = [gradientLeftColor?.cgColor, gradientRightColor?.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        view.layer.insertSublayer(gradient, at: 0)
        
        lbTitle.text = title
    }
}
