//
//  SlideMenu.swift
//  Rider
//
//  Created by Tien Dat on 11/3/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import Foundation
import UIKit

class SlideMenu: BaseXibView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var signUpToDriveView: UIView!
    
    @IBOutlet weak var FreeRidesView: UIView!
    
    @IBOutlet weak var RidesHistoryView: UIView!
    
    @IBOutlet weak var PaymentView: UIView!
    
    @IBOutlet weak var HelpView: UIView!
    
    @IBOutlet weak var SettingsView: UIView!
    
    override func initControl() {
      
        
        Bundle.main.loadNibNamed("SlideMenu", owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        _ = view.addConstraintFillInView(view: self, commenParrentView: self)
        
        signUpToDriveView.layer.cornerRadius = 10

        
    }
    
    
}


