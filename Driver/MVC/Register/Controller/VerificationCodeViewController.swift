//
//  VerificationCodeViewController.swift
//  Driver
//
//  Created by Tien Dat on 11/8/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import UIKit

class VerificationCodeViewController: BaseViewController {
    
    @IBOutlet weak var EnterVeriCodeTopGuide: NSLayoutConstraint!
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet var lbCodes: [UILabel]!
    @IBOutlet var lines: [UIView]!
    @IBOutlet var inputCodeView: UIView!
    @IBOutlet weak var lbPhoneNumber: UILabel!
    @IBOutlet weak var lbInvalidCode: UILabel!
    @IBOutlet weak var btnResendCode: UIButton!
    @IBOutlet var lbTimers: [UILabel]!
    
    var loginParam = CGLoginParam()
    lazy var activeParam: CGActiveParam = CGActiveParam()
    fileprivate var hiddenTextfield = UITextField()
    
    private var timer:Timer?
    private var countDownTime = 30
    private let idIntroduceRegisterViewController = "IntroduceRegisterViewController"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                     selector: #selector(VerificationCodeViewController.countDown),
                                     userInfo: nil, repeats: true)
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.inputViewDidTap(sender:)))
        inputCodeView.isUserInteractionEnabled = true
        inputCodeView.addGestureRecognizer(tap)
        
        setupInputView()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //hard-code need add country code
        lbPhoneNumber.text = "Enter verification code we have sent to \(activeParam.mobile!)"
    }
    
    func inputViewDidTap(sender: UITapGestureRecognizer) {
        hiddenTextfield.becomeFirstResponder()
    }
    
    func countDown(){
        if countDownTime < 0 { btnResendCode.isHidden = false }
        else {
            countdownLabel.text = String(format: "0:%d", countDownTime )
            self.view.setNeedsLayout()
            countDownTime -= 1
        }
    }
    
    @IBAction func btnBackDidClick(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    /// active validate code
    func activeValidateCode() {
        if !isVerifyCodeValid { showInvalidVerify(); return }
        
        print("\(hiddenTextfield.text)")
        activeParam.activation = CGActiveParam.CGActivation()
        activeParam.activation!.code = Int(hiddenTextfield.text!)
        activeParam.type = "rider"
        activeParam.countryCode = "VN" //hard-code
        
        let completeBlock: CompletionBlock = { (task) -> APITask in
            self.btnResendCode.hideIndicator()
            var error = CGActive.CGError()
            do {
                guard let response = task.result as? CGActive else {
                    throw APIError.conflictTypeResponse
                }
                
                guard response.status == 1 else {
                    //show error from server
                    error = response.error!
                    throw APIError.clientInputError
                }
                Session.shareInstance.activeInfo = response
                self.performSegue(withIdentifier: self.idIntroduceRegisterViewController, sender: nil)
            } catch APIError.clientInputError {
                self.showInvalidVerify()
                let title = error.title
                let message = error.message
                self.alert(title: title, message: message)
            } catch {
                self.alert(title: "Undifined", message: "")
            }
            return task
        }
        
        
        //        "mobile": "969740391",
        
        let api = CGAPI()
        _ = api.active(sender: activeParam, completeBlock: completeBlock)
    }
    
    var isVerifyCodeValid: Bool {
        //fill all field
        if self.hiddenTextfield.text?.characters.count == lbCodes.count {
            return true
        }
        return false
    }
    
    func showInvalidVerify() {
        lbInvalidCode.isHidden = false
        hiddenTextfield.text = ""
        _ = lbCodes.map { $0.text = " " }
        _ = lines.map { $0.setStatus(state: 3) }
    }
 

}

//MARK: TextfieldDelegate
extension VerificationCodeViewController {
    fileprivate func setupInputView() {
        //show the line
        _ = lines.map { $0.setStatus(state: 2) }
        hiddenTextfield.isHidden = true
        view.addSubview(hiddenTextfield)
        hiddenTextfield.addTarget(self, action: #selector(self.textFieldDidChange(sender:)),
                                  for: UIControlEvents.editingChanged)
        hiddenTextfield.keyboardType = .numberPad
    }
    
    func textFieldDidChange(sender: UITextField) {
        //set empty input view
        guard sender.hasText else {
            _ = lbCodes.map { $0.text = " " }
            _ = lines.map { $0.setStatus(state: 2) }
            return
        }
        
        //limit string lenght of textfield
        let text = sender.text!
        if text.characters.count > lbCodes.count {
            hiddenTextfield.text = text.substring(with: 0..<lbCodes.count)
            return
        }
        
        if text.characters.count < lbCodes.count {
            lbInvalidCode.isHidden = true
        }
        
        //set value and style for inputview
        let count = sender.text!.characters.count
        for i in 0..<count {
            
            lbCodes[i].text = text[i]
            lines[i].setStatus(state: 1)
        }
        for i in count..<lbCodes.count {
            lbCodes[i].text = " "
            lines[i].setStatus(state: 2)
        }
        //if input field is full, request active account
        if count == lbCodes.count {
           // activeValidateCode()
            
            //FOR DEMO
            performSegue(withIdentifier: "RegisterViewController", sender: nil)
        }
    }
}


fileprivate extension UIView {
    
    /// Change status of underline view
    ///
    /// - parameter state: 1: Forcus 2: Unforcus 3: Error
    func setStatus(state: Int) {
        if state == 1 {         //forcus
            backgroundColor = UIColor.RGB(red: 49, green: 179, blue: 239)
        } else if state == 2 {  //unfocus
            backgroundColor = UIColor.RGB(red: 49, green: 179, blue: 239, alpha: 0.5)
        } else {                //error
            backgroundColor = UIColor.RGB(red: 222, green: 0, blue: 0, alpha: 0.5)
        }
    }
}
