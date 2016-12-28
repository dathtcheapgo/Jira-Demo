//
//  SelecCountryViewController.swift
//  Driver
//
//  Created by Tien Dat on 11/8/16.
//  Copyright © 2016 Tien Dat. All rights reserved.
//

import UIKit
import PhoneNumberKit
import AccountKit
class SelectCountryViewController: BaseViewController {

    @IBOutlet weak var lbCountryCode: UILabel!
    @IBOutlet weak var lbFlag: UILabel!
    @IBOutlet weak var lbCountryName: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var lbDescription: UILabel!
    
    @IBOutlet weak var phoneNumbertxt: UITextField!
    
    lazy var loginParam: CGLoginParam = CGLoginParam()
    var inputData = (countryCode: "", countryName: "", phone: "")
    
    private let idCodeViewController = "VerificationCodeViewController"
    private var countryListVCID  = "CountryListViewController"
    var countryListVC:CountryListViewController?
    
    
    var accountkit:AKFAccountKit?
    var pendingLoginViewController:AKFViewController?
    var authorizationCode:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isHidden = true
        lbDescription.isHidden = false
        setupTextField()
        
        if accountkit == nil {
            accountkit = AKFAccountKit(responseType: .authorizationCode)
        }
        pendingLoginViewController = accountkit!.viewControllerForLoginResume() as? AKFViewController
        pendingLoginViewController?.delegate = self
        
        loginWithPhone()
        
        // Do any additional setup after loading the view.
    }
    
    func prepareLoginViewController(loginViewController: AKFViewController) {
        loginViewController.delegate = self
    }
    
    func signupWithEmailButtonPressed() {
        let inputState = NSUUID().uuidString
        let vc: AKFViewController = accountkit!.viewControllerForEmailLogin(withEmail: nil, state: inputState) as! AKFViewController
        self.prepareLoginViewController(loginViewController: vc)
        self.present(vc as! UIViewController, animated: true, completion: nil)
    }
    
    func loginWithPhone(){
        //let preFillPhoneNumber:AKFPhoneNumber = "01239583993859839"
        let preFillPhoneNumber = AKFPhoneNumber(countryCode: "", phoneNumber: "")
        let inputState = NSUUID().uuidString
        
        let vc:AKFViewController = accountkit!.viewControllerForPhoneLogin(with: preFillPhoneNumber, state: inputState) as! AKFViewController
        
        vc.enableSendToFacebook = true
        
        self.prepareLoginViewController(loginViewController: vc)
      
      self.present(vc as! UIViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let data = countryListVC?.selectionData {
            print("data : \(data)")
            lbCountryCode.text = data.phone
            lbFlag.text = data.countryCode.flag()
            lbCountryName.titleLabel?.text = data.countryCode
            countryListVC = nil
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func countryBtnPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: countryListVCID, sender: nil)
    }
    
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
//        if !phoneNumbertxt.hasText {
//            alert(title: "Phone number is required", message: "")
//            return
//        }
//        if !isPhoneNumberValid() { showAlertInvalidPhoneNumber(); return }
//        
//        if let selectedData = countryListVC?.selectionData { inputData = selectedData }
//        else {
//            //hard-code
//            inputData = (countryCode: "VN", countryName: "", phone: phoneNumbertxt.text!)
//        }
//        
//        loginParam.countryCode = inputData.countryCode
//        loginParam.type = "rider"
//        loginParam.mobile = phoneNumbertxt.text
//        countryListVC = nil
//        
//        sender.showIndicator()
//        let api = CGAPI()
//        let completeBlock: CompletionBlock = { (task) -> APITask in
//            sender.hideIndicator()
//            do {
//                guard let response = task.result as? CGBaseResult else {
//                    throw APIError.conflictTypeResponse
//                }
//                guard response.status == 1 else { throw APIError.undefined }
//                self.performSegue(withIdentifier: self.idCodeViewController, sender: nil)
//            } catch APIError.conflictTypeResponse {
//                self.alert(title: "ConflictTypeResponse", message: "")
//            } catch {
//                self.alert(title: "Undifined", message: "")
//            }
//            return task
//        }
//        _ = api.login(sender: loginParam, completeBlock: completeBlock)
        
        self.performSegue(withIdentifier: self.idCodeViewController, sender: nil)
    }
    
    func isPhoneNumberValid() -> Bool {
        
        do {
            let phoneNumberKit = PhoneNumberKit()
            let _ = try phoneNumberKit.parse(phoneNumbertxt.text!)
            return true //hard-code skip client check
        }
        catch {
            print("Generic parser error")
        }
        return false
    }
    
    func showAlertInvalidPhoneNumber() {
        alert(title: "Invalid phone number",
              message: "Do this popup need a different design?")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == countryListVCID {
                countryListVC = segue.destination as? CountryListViewController
            } else if segue.identifier == idCodeViewController {
                guard let codeViewController = segue.destination as? VerificationCodeViewController else {
                    fatalError("Wrong CodeViewController id")
                }
                
                codeViewController.loginParam = loginParam
                
                codeViewController.activeParam.mobile = phoneNumbertxt.text
        }
    }
   

}

extension SelectCountryViewController {
    func setupTextField() {
        phoneNumbertxt.addTarget(self,
                                 action: #selector(self.textFieldDidChange(sender:)),
                                 for: UIControlEvents.editingChanged)
    }
    
    func textFieldDidChange(sender: UITextField) {
        if phoneNumbertxt.hasText {
            nextButton.isHidden = false
            lbDescription.isHidden = true
        } else {
            nextButton.isHidden = true
            lbDescription.isHidden = false
        }
    }
}

extension SelectCountryViewController : AKFViewControllerDelegate {
    
    
    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("did complete login with AuthCode \(code) state \(state)")
        performSegue(withIdentifier: "RegisterViewController", sender: nil)
    }
    
    func viewController(_ viewController: UIViewController!, didFailWithError error: Error!) {
        print("error \(error)")
    }
    
    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("did complete login with access token \(accessToken.tokenString) state \(state)")
    }
    
}
