//
//  LogInVC.swift
//  omninosIosTest
//
//  Created by Prince 2.O on 30/11/22.
//

import UIKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var lblFirebaseError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    @IBAction func forgotButtonPressed(_ sender: UIButton)
    {
        self.navigateToResetPassVC()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton)
    {
        self.loginUser()
    }
    
    @IBAction func createAccButtonPressed(_ sender: UIButton)
    {
        self.navigateToCreateAccVC()
    }
}

extension LogInVC {
    
    private func navigateToResetPassVC()
    {
        guard let resetPasswordVC = self.storyboard?.instantiateViewController(identifier: String(describing: ForgotPasswordVC.self)) as? ForgotPasswordVC else {
            debugPrint("Forgot Password VC Not Found")
            return
        }
        self.navigationController?.pushViewController(resetPasswordVC,
                                                      animated: true)
    }
    
    private func loginUser()
    {
        // Check Is Internet Connected
        if (NetworkUtility.shared.isConnected) {
            
            let emailValidator = EmailValidation()
            let passwordValidator = PasswordValidation()
            let emailValidationResult = emailValidator.validate(email: self.txtFldEmail.text!)
            let passValidationResult = passwordValidator.validate(password: self.txtFldPassword.text!)
            
            // Validate Email and Password
            if (emailValidationResult.success && passValidationResult.success) {
                self.lblEmailError.text = nil
                self.lblPasswordError.text = nil
                
                // Navigate To AddTaskVC
                self.view.isUserInteractionEnabled = false
                progressHUD.showSpinner()
                FirebaseManager.login(email: self.txtFldEmail.text!, password: self.txtFldPassword.text!, view: self.view) { (loginErrorMsg) in
                    progressHUD.stopSpinner()
                    self.view.isUserInteractionEnabled = true
                    self.lblFirebaseError.text = loginErrorMsg
                }
            } else { // Display Validation Error Messages
                self.lblEmailError.text = emailValidationResult.errorMsg
                self.lblPasswordError.text = passValidationResult.errorMsg
            }
            
        } else { // Show No Internet Connection Alert
            AlertUtility.shared.showNoInternetAlert(viewController: self)
        }
    }
    
    private func navigateToCreateAccVC()
    {
        guard let createAccountVC = self.storyboard?.instantiateViewController(identifier: String(describing: SignUpVC.self)) as? SignUpVC else {
            debugPrint("Create Acc VC Not Found")
            return
        }
        self.navigationController?.pushViewController(createAccountVC,
                                                      animated: true)
    }
}

extension LogInVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        self.lblFirebaseError.text = nil
        self.lblEmailError.text = nil
        self.lblPasswordError.text = nil
        return true
    }
}
