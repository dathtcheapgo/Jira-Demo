//
//  BookingTopBar.swift
//  Driver
//
//  Created by Tien Dat on 11/9/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import Foundation
import UIKit
public enum status{
    case finding
    case online
    case offline
    case waiting
}
class BookingTopBar: BaseXibView {
    
    @IBOutlet var view: HBorderView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var lblocation: UILabel!
    
    @IBOutlet weak var giftImage: UIImageView!
    
    var screen:status = .finding {
        didSet{
            setupColoStyle()
        }
    }
    
    
    override func initControl() {
        Bundle.main.loadNibNamed("BookingTopBar", owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        setupColoStyle()
        addSubview(view)
        _ = view.addConstraintFillInView(view: self, commenParrentView: self)
        
    }
    
    func setupColoStyle(){
        switch  screen {
        case .online:
            view.backgroundColor = UIColor.online()
            lblocation.isHidden = false
            logoImage.isHidden = true
        case .offline:
            view.backgroundColor = UIColor.home()
            lblocation.isHidden = true
            logoImage.isHidden = false
        default:
            view.gradientLeftColor = UIColor.findingleft()
            view.gradientRightColor = UIColor.findingright()
            lblocation.isHidden = false
            logoImage.isHidden = true
        }
    }
}
fileprivate extension UIColor{
    static func home() -> UIColor {
        return UIColor(netHex: 0x042A67)
    }
    
    static func findingleft() -> UIColor {
        return UIColor(netHex: 0x00FFC4)
    }
    
    static func findingright() -> UIColor {
        return UIColor(netHex: 0x0086FF)
    }
    static func online() -> UIColor {
        return UIColor(netHex: 0x004AFF)
    }
}
