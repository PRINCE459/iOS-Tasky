//
//  CustomProgressHUD.swift
//  ParkLinqValidation
//
//  Created by Prince 2.O on 10/11/22.
//

import Foundation
import ProgressHUD

struct progressHUD {
    
    static func showSpinner()
    {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorAnimation = .systemRed
        ProgressHUD.show()
    }
    
    static func stopSpinner()
    {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorAnimation = .systemRed
        ProgressHUD.dismiss()
    }
}
