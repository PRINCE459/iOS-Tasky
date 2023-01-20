//
//  NameValidation.swift
//  Tasky
//
//  Created by Prince 2.O on 02/12/22.
//

import Foundation

struct NameValidation {
    
    func validate(name: String) -> ValidationResult
    {
        if (name.count > 0) {
            if (name.count < 20) {
                return ValidationResult(success: true, errorMsg: nil)
            } else {
                return ValidationResult(success: false, errorMsg: ErrorTexts.invalidName)
            }
        }
        
        return ValidationResult(success: false, errorMsg: ErrorTexts.mandatoryField)
    }
}
