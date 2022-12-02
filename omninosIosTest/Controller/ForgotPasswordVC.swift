//
//  ForgotPasswordVC.swift
//  omninosIosTest
//
//  Created by Prince 2.O on 30/11/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtFldResetPassword: UITextField!
    @IBOutlet weak var lblFirebaseError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton)
    {
        self.resetPassword()
    }
}

extension ForgotPasswordVC {
    
    private func resetPassword() {
        
        // Check Is Internet Connected
        if (NetworkUtility.shared.isConnected)
        {
            let emailValidator = EmailValidation()
            let emailValidationResult = emailValidator.validate(email: self.txtFldResetPassword.text!)
            
            // Validate Email Address
            if (emailValidationResult.success) {
                self.lblEmailError.text = nil
                // Navigate to LogInVC
                self.view.isUserInteractionEnabled = false
                progressHUD.showSpinner()
                FirebaseManager.forgotPassword(email: self.txtFldResetPassword.text!) { (forgotPassErrorMsg) in
                    progressHUD.stopSpinner()
                    self.view.isUserInteractionEnabled = true
                    self.lblFirebaseError.text = forgotPassErrorMsg
                } success: {
                    AlertUtility.shared.showSimpleOkAlert(viewController: self) { (okayBtnAction) in
                        progressHUD.stopSpinner()
                        self.view.isUserInteractionEnabled = true
                        self.navigateToLogInVC()
                    }
                }
            } else { // Display Validation Errors
                self.lblEmailError.text = emailValidationResult.errorMsg
            }
            
        } else { // Show No Internet Connection Alert
            AlertUtility.shared.showNoInternetAlert(viewController: self)
        }
    }
    
    private func navigateToLogInVC()
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgotPasswordVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        self.lblFirebaseError.text = nil
        self.lblEmailError.text = nil
        return true
    }
}
