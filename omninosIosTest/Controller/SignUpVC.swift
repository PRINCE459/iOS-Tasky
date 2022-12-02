//
//  SignUpVC.swift
//  omninosIosTest
//
//  Created by Prince 2.O on 30/11/22.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var txtFldEmail: UITextField!
    @IBOutlet weak var txtFldName: UITextField!
    @IBOutlet weak var txtFldPhoneNo: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var lblFirebaseError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblPhoneNoError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    @IBAction func createAccButtonPressed(_ sender: UIButton)
    {
        self.registerUser()
    }
}

extension SignUpVC {
    
    private func registerUser()
    {
        // Check Is Internet Connected
        if (NetworkUtility.shared.isConnected) {
            
            let emailValidator = EmailValidation()
            let nameValidator = NameValidation()
            let phoneNoValidator = PhoneNoValidation()
            let passwordValidator = PasswordValidation()
            
            let emailValidationResult = emailValidator.validate(email: self.txtFldEmail.text!)
            let nameValidatorResult = nameValidator.validate(name: self.txtFldName.text!)
            let phoneNovalidationResult = phoneNoValidator.validate(phoneNo: self.txtFldPhoneNo.text!)
            let passwordValidationResult = passwordValidator.validate(password: self.txtFldPassword.text!)
            
            // Validate Email, Name, PhoneNumber and Password
            if (emailValidationResult.success && nameValidatorResult.success && phoneNovalidationResult.success && passwordValidationResult.success) {
                
                progressHUD.showSpinner()
                self.view.isUserInteractionEnabled = false
                
                self.lblEmailError.text = nil
                self.lblNameError.text = nil
                self.lblPhoneNoError.text = nil
                self.lblPasswordError.text = nil
                
                // Register User, Save Data to DB, Read Data from DB and Navigate to AddTaskVC
                FirebaseManager.register(email: self.txtFldEmail.text!, password: self.txtFldPassword.text!) { (registerErrorMsg) in
                    // Register Error Block
                    progressHUD.stopSpinner()
                    self.view.isUserInteractionEnabled = true
                    self.lblFirebaseError.text = registerErrorMsg
                } success: {
                    self.saveUserData()
                    progressHUD.stopSpinner()
                    self.view.isUserInteractionEnabled = true
                }
                
            } else { // Display Validation Errors
                self.lblEmailError.text = emailValidationResult.errorMsg
                self.lblNameError.text = nameValidatorResult.errorMsg
                self.lblPhoneNoError.text = phoneNovalidationResult.errorMsg
                self.lblPasswordError.text = passwordValidationResult.errorMsg
            }
            
        } else { // Show No Internet Connection Alert
            AlertUtility.shared.showNoInternetAlert(viewController: self)
        }
    }
    
    private func saveUserData()
    {
        FirebaseManager.saveData(email: self.txtFldEmail.text!, name: self.txtFldName.text!, phoneNo: self.txtFldPhoneNo.text!, password: self.txtFldPassword.text!) { (docID) in
            print("DocID is \(docID)")
            FirebaseManager.readData(docID: docID)
        }
    }
}

extension SignUpVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        self.lblFirebaseError.text = nil
        self.lblEmailError.text = nil
        self.lblNameError.text = nil
        self.lblPhoneNoError.text = nil
        self.lblPasswordError.text = nil
        return true
    }
}
