//
//  PhoneNoValidation.swift
//  Tasky
//
//  Created by Prince 2.O on 02/12/22.
//

import Foundation

struct PhoneNoValidation {
    
    func validate(phoneNo: String) -> ValidationResult
    {
        if (phoneNo.count > 0) {
            if (phoneNo.count == 10) {
                return ValidationResult(success: true, errorMsg: nil)
            } else {
                return ValidationResult(success: false, errorMsg: ErrorTexts.invalidPhoneNo)
            }
        }
        
        return ValidationResult(success: false, errorMsg: ErrorTexts.mandatoryField)
    }
}
