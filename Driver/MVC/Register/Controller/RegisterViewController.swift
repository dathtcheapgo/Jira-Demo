//
//  IntroduceRegisterViewController.swift
//  Rider
//
//  Created by Tien Dat on 10/27/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: TintTextField!
    
    @IBOutlet weak var txtInviteCode: UITextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btGo: UIButton!
    
    @IBOutlet weak var lbEmailInvalid: UILabel!
    
    @IBOutlet weak var lbInvitationCodeInvalid: UILabel!
    
    
    @IBOutlet weak var topSpacing: NSLayoutConstraint!
    var originTopSpace:CGFloat?
    
    let imagePicker = UIImagePickerController()
    var crossButton:CrossButton!
    @IBOutlet weak var btnGo: UIButton!
    
    
    @IBAction func btGoDidClick(_ sender: UIButton) {
        if txtEmail.hasText && !isValidEmail(testStr: txtEmail.text!) {
            alert(title: "Invalid email", message: "", handler: { (action) in
                self.lbEmailInvalid.isHidden = false
                let color = UIColor(red: 222, green: 0, blue: 0)
                self.txtEmail.tintColor = color
                self.txtEmail.textColor = color
                self.txtEmail.addBottomBorder(color: color)
                self.txtEmail.becomeFirstResponder()
                
            })
            
            
        } else {
            performSegue(withIdentifier: "Booking", sender: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //originTopSpace = topSpacing.constant
        btGo.layer.cornerRadius = btGo.frame.size.height / 2
        self.view.layoutIfNeeded()
        //hard-code here
//        crossButton = CrossButton(frame:
//            CGRect(x: imgAvatar.frame.origin.x + imgAvatar.frame.width * 0.75,
//                   y: imgAvatar.frame.origin.y,
//                   width: 20, height: 20))
//        
//        crossButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        self.view.addSubview(crossButton)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShown(notification:)),
                                               name:NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name:NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    
    func keyboardWillShown(notification: NSNotification) {
       
        
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        topSpacing.constant = originTopSpace! - keyboardHeight + 60
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        
        topSpacing.constant = originTopSpace!
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        
        txtFirstName.addBottomBorder(color: UIColor(netHex: 0xe6e6e6))
        txtLastName.addBottomBorder(color: UIColor(netHex: 0xe6e6e6))
        txtEmail.addBottomBorder(color: UIColor(netHex: 0xe6e6e6))
        txtInviteCode.addBottomBorder(color: UIColor(netHex: 0xe6e6e6))
    }
    
    func buttonAction(sender: UIButton!) {
        imgAvatar.image = nil
        crossButton.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set textfield delegate to use custom action
        setupTextField()
        
        lbEmailInvalid.isHidden = true
        lbInvitationCodeInvalid.isHidden = true
        
        //set image picker delegate
        imagePicker.delegate = self
        
        self.view.layoutIfNeeded()
        imgAvatar.layer.cornerRadius = imgAvatar.frame.size.height / 2
        imgAvatar.layer.masksToBounds = true
        
        updateStyleForButtonGo()
    }
    
    /// Tap Gesture Action
    /// Present imagepicker view after tapped on avatarImageView
    /// - parameter sender: Tao Gesture Regconizer
    @IBAction func avatarPicture(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    var isInputFieldValid: Bool {
        if txtEmail.hasText && txtLastName.hasText && txtFirstName.hasText { return true }
        return false
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
}

extension RegisterViewController{
    func setupTextField() {
        txtEmail.addTarget(self,
                           action: #selector(self.textFieldDidChange(sender:)),
                           for: UIControlEvents.editingChanged)
        txtLastName.addTarget(self,
                              action: #selector(self.textFieldDidChange(sender:)),
                              for: UIControlEvents.editingChanged)
        txtFirstName.addTarget(self,
                               action: #selector(self.textFieldDidChange(sender:)),
                               for: UIControlEvents.editingChanged)
    }
    
    func textFieldDidChange(sender: UITextField) {
        updateStyleForButtonGo()
    }
    
    func updateStyleForButtonGo() {
        if !txtEmail.hasText && !txtFirstName.hasText &&
            !txtLastName.hasText && imgAvatar.image == nil {
            btnGo.setState(isSkip: true)
        } else { btnGo.setState(isSkip: false) }
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imgAvatar.contentMode = .scaleAspectFill
            self.imgAvatar.image = pickedImage
            crossButton.isHidden = false
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

fileprivate extension UIButton {
    func setState(isSkip: Bool) {
        let color = UIColor.RGB(red: 4, green: 42, blue: 103)
        if isSkip {
            setTitle("Skip", for: .normal)
            setTitleColor(color, for: .normal)
            backgroundColor = UIColor.white
            layer.borderWidth = 0.5
            layer.borderColor = UIColor(red: 151, green: 151, blue: 151).cgColor
            
            
        }
        else {
            setTitle("Go", for: .normal)
            setTitleColor(UIColor.white, for: .normal)
            backgroundColor = color
            
        }
    }
}
