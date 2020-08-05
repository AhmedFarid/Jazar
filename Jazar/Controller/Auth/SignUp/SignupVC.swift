//
//  SignupVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 6/30/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class SignupVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var fullName: textFieldView!
    @IBOutlet weak var phone: textFieldView!
    @IBOutlet weak var email: textFieldView!
    @IBOutlet weak var password: textFieldView!
    @IBOutlet weak var privacy: UIButton!
    
    var accepte: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func viewAction(_ sender: Any) {
        let vc = aboutUsVC(nibName: "aboutUsVC", bundle: nil)
        vc.pageName = "policy"
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func privacyBtn(_ sender: Any) {
        if accepte == false {
            accepte = true
            self.privacy.setImage(UIImage(named: "Group 1597"), for: .normal)
        }else if accepte == true {
            accepte = false
            self.privacy.setImage(UIImage(named: "NoGroup 1597"), for: .normal)
        }
    }
    
    
    
    
    @IBAction func signUpBTNAction(_ sender: Any) {
        
        guard accepte == true else {
            let messages = NSLocalizedString("Please Approve the privacy policy in the application", comment: "hhhh")
            let title = NSLocalizedString("Sign Up", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        let response = Validation.shared.validate(values:
            (ValidationType.alphabeticString, fullName.text ?? "")
            ,(ValidationType.phoneNo, phone.text ?? "")
            ,(ValidationType.email, email.text ?? "")
            ,(ValidationType.password, password.text ?? ""))
        switch response {
        case .success:
            loaderHelper()
            authApi.register(full_name: fullName.text ?? "", email: email.text ?? "", phone: phone.text ?? "", password: password.text ?? "", password_confirmation: password.text ?? ""){ (error, success, apiSuccess,Register,statusCode) in
                if success {
                    if statusCode == 200 {
                            self.stopAnimating()
                            self.dismiss(animated: true, completion: nil)
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "SignUp", message: "email or phone are used")
                    }
                    
                }else {
                    self.showAlert(title: "SignUp", message: "Check your network")
                    self.stopAnimating()
                }
                
            }
            break
        case .failure(_, let message):
            showAlert(title: "SignUp", message: message.localized())
        }
    }
}
