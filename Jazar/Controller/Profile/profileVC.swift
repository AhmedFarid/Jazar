//
//  profileVC.swift
//  MGH Kitchen Tools
//
//  Created by Ahmed farid on 7/14/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class profileVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var emailTF: textFieldView!
    @IBOutlet weak var phoneTF: textFieldView!
    @IBOutlet weak var fullName: textFieldView!
    @IBOutlet weak var segmentProfile: UISegmentedControl!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var edit: buttonView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpNavColore(false)
        
    }
    
    func setUpData() {
        loaderHelper()
        profileApi.getProfileApi { (error, success, profile) in
            if success {
                self.emailTF.text = profile?.data?.email
                self.phoneTF.text = profile?.data?.phone
                self.fullName.text = profile?.data?.fullName
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    
    @IBAction func editBtn(_ sender: Any) {
        switch segmentProfile.selectedSegmentIndex
        {
        case 0:
            loaderHelper()
            profileApi.editProfielApi(full_name: fullName.text ?? "", email: emailTF.text ?? "", phone: phoneTF.text ?? "") { (error, success, message) in
                if success {
                    let title = NSLocalizedString("Edit Profile", comment: "profuct list lang")
                    let message = NSLocalizedString("Success Eidt Profile", comment: "profuct list lang")
                    self.showAlert(title: title, message: message)
                    self.setUpData()
                    self.stopAnimating()
                }
                self.stopAnimating()
            }
        case 1:
            loaderHelper()
            profileApi.changePasswordApi(password: phoneTF.text ?? "", password_confirmation: emailTF.text ?? "", old_password: fullName.text ?? "") { (error, success, message) in
                if success {
                    if message?.success == true {
                        let title = NSLocalizedString("Change Password", comment: "profuct list lang")
                        let message = NSLocalizedString("Password Eidt Success", comment: "profuct list lang")
                        self.showAlert(title: title, message: message)
                        self.stopAnimating()
                        self.fullName.text = ""
                        self.phoneTF.text = ""
                        self.emailTF.text = ""
                    }else {
                        let title = NSLocalizedString("Change Password", comment: "profuct list lang")
                        let message = NSLocalizedString("Password Eidt Faild", comment: "profuct list lang")
                        self.showAlert(title: title, message: message)
                        self.stopAnimating()
                        self.fullName.text = ""
                        self.phoneTF.text = ""
                        self.emailTF.text = ""
                    }
                }
                self.stopAnimating()
            }
        default:
            break;
        }
        
    }
    
    @IBAction func segemtProfileBtm(_ sender: Any) {
        switch segmentProfile.selectedSegmentIndex
        {
        case 0:
            fullName.text = ""
            phoneTF.text = ""
            emailTF.text = ""
            
            
            let fullNames = NSLocalizedString("Full Name", comment: "profuct list lang")
            fullNameLabel.text = fullNames
            let phone = NSLocalizedString("Phone", comment: "profuct list lang")
            phoneLabel.text = phone
            let email = NSLocalizedString("Email", comment: "profuct list lang")
            emailLabel.text = email
            
            fullName.placeholder = fullNames
            phoneTF.placeholder = phone
            emailTF.placeholder = email
            
            fullName.isSecureTextEntry = false
            phoneTF.isSecureTextEntry = false
            emailTF.isSecureTextEntry = false
            
            fullName.keyboardType = .default
            phoneTF.keyboardType = .phonePad
            emailTF.keyboardType = .emailAddress
            
            setUpData()
        case 1:
            let oldPssword = NSLocalizedString("Old Pssword", comment: "profuct list lang")
            fullNameLabel.text = oldPssword
            let newPassword = NSLocalizedString("New Password", comment: "profuct list lang")
            phoneLabel.text = newPassword
            let passwordConfirmation = NSLocalizedString("Password Confirmation", comment: "profuct list lang")
            emailLabel.text = passwordConfirmation
            
            fullName.placeholder = oldPssword
            phoneTF.placeholder = newPassword
            emailTF.placeholder = passwordConfirmation
            
            fullName.isSecureTextEntry = true
            phoneTF.isSecureTextEntry = true
            emailTF.isSecureTextEntry = true
            
            fullName.text = ""
            phoneTF.text = ""
            emailTF.text = ""
            
            fullName.keyboardType = .default
            phoneTF.keyboardType = .default
            emailTF.keyboardType = .default
        default:
            break;
        }
    }
    
}
