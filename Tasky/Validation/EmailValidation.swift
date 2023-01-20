//
//  EmailValidation.swift
//  Tasky
//
//  Created by Prince 2.O on 02/12/22.
//

import Foundation

struct EmailValidation {
    
    func validate(email: String) -> ValidationResult
    {
        if (email.count > 0) {
            if (email.isValidEmail()) {
                return ValidationResult(success: true, errorMsg: nil)
            } else {
                return ValidationResult(success: false, errorMsg: ErrorTexts.invalidEmail)
            }
        }
        
        return ValidationResult(success: false, errorMsg: ErrorTexts.mandatoryField)
    }
}
