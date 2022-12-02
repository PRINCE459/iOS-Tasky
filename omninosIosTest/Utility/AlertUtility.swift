//
//  AlertUtility.swift
//  ParkLinqValidation
//
//  Created by Prince 2.O on 06/11/22.
//

import UIKit

class AlertUtility {
    
    static let shared = AlertUtility()
    
    func showLogOutAlert(viewController: UIViewController, yesButtonAction: @escaping (UIAlertAction) -> Void)
    {
        let alert = UIAlertController(title: Constants.lgaTitle,
                                      message: Constants.lgaMsg,
                                      preferredStyle: .alert)
        
        let yesButton = UIAlertAction(title: Constants.lgaBtnYes,
                                      style: .default,
                                      handler: yesButtonAction)
        
        let noButton = UIAlertAction(title: Constants.lgaBtnNo,
                                     style: .default,
                                     handler: nil)
        alert.addAction(yesButton)
        alert.addAction(noButton)
        viewController.present(alert,
                   animated: true,
                   completion: nil)
    }
    
    func showNoInternetAlert(viewController: UIViewController)
    {
        let alert = UIAlertController(title: Constants.niaTitle,
                                      message: Constants.niaMsg,
                                      preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: Constants.niaOkBtnTitle,
                                         style: .default,
                                         handler: nil)
        
        alert.addAction(okButton)
        viewController.present(alert,
                   animated: true,
                   completion: nil)
    }
    
    func showSimpleOkAlert(viewController: UIViewController, completionHandler: @escaping (UIAlertAction) -> Void)
    {
        let simpleOkAlert = UIAlertController(title: Constants.okaTitle,
                                              message: Constants.okaMsg,
                                              preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: Constants.okaBtnTitle,
                                     style: .default,
                                     handler: completionHandler)
        
        simpleOkAlert.addAction(okButton)
        viewController.present(simpleOkAlert,
                               animated: true,
                               completion: nil)
    }
    
}
