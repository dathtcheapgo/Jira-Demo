//
//  IssuePopup.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/20/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

enum DeviceError: String {
    case dontHaveInternetConnection = "img_error_popupGPS"
    case dontEnableGPS              = "img_error_popupInternet"
}

class ErrorPopup: BaseXibView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var imageView: UIImageView!
    private var blockView = UIView()
    
    override func initControl() {
        Bundle.main.loadNibNamed("ErrorPopup", owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        _ = view.addConstraintFillInView(view: self, commenParrentView: self)
        
     
    }
    
    func show(issueType: DeviceError, parrentView: UIView) {
        if superview == nil {
            blockView.removeFromSuperview()
            blockView.translatesAutoresizingMaskIntoConstraints = false
            parrentView.addSubview(blockView)
            _ = blockView.addConstraintFillInView(view: parrentView, commenParrentView: parrentView)
            
            imageView.image = UIImage(named: issueType.rawValue)
            isHidden = false
            
            translatesAutoresizingMaskIntoConstraints = false
            blockView.addSubview(self)
            let margin: CGFloat = 20
            _ = leadingMarginToView(view: blockView, commonParrentView: blockView, margin: margin)
            _ = trailingMarginToView(view: blockView, commonParrentView: blockView, margin: -margin)
            _ = addConstraintCenterYToView(view: blockView, commonParrentView: blockView)
        } else { blockView.isHidden = false }
    }
    
    func hide() {
        blockView.isHidden = true
    }
}
