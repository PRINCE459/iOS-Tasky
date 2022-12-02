//
//  PasswordValidation.swift
//  omninosIosTest
//
//  Created by Prince 2.O on 02/12/22.
//

import Foundation

struct PasswordValidation {
    
    func validate(password: String) -> ValidationResult
    {
        if (password.count > 0) {
            if (password.count >= 8 && password.count <= 20) {
                return ValidationResult(success: true, errorMsg: nil)
            } else {
                return ValidationResult(success: false, errorMsg: ErrorTexts.invalidPassword)
            }
        }
        
        return ValidationResult(success: false, errorMsg: ErrorTexts.mandatoryField)
    }
}
