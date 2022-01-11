//
//  AlertPresenter.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 11.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//
import UIKit
import Foundation
class AlertPresenter {
    func showAlert(title:String,message:String,viewController: UIViewController)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: false, completion: nil)
    }
      
}
