//
//  BaseViewController.swift
//  drivers
//
//  Created by Đinh Anh Huy on 10/10/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

enum BaseError: Error {
    case Undefined
}

class BaseViewController: UIViewController, CGNavbarDelegate {

    @IBOutlet var navbar: CGNavbar?
    private lazy var errorPopup: ErrorPopup = ErrorPopup()
    //need add what view need tap to this list
    lazy var tapableViews: [UIView] = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewDidTap(sender:)))
        tapGesture.cancelsTouchesInView = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        navbar?.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func viewDidTap(sender: UIGestureRecognizer) {
        view.endEditing(true)
        errorPopup.hide()
    }
    
    //CGNavbarDelegate
    func navbarDidClickBack(sender: CGNavbar) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func showError(deviceError: DeviceError, withBlockView: Bool = true) {
        errorPopup.show(issueType: deviceError, parrentView: view)
    }
    
    //Show message
    func alert(title: String?, message: String?,
               handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}




