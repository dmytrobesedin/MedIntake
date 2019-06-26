//
//  AuthViewController.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 5/16/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import  MessageUI

class AuthViewController: UIViewController {
    var isReg: Bool = false{
        willSet{
            if newValue{
                titleLabel.text = "Sign in"
                loginButtonOutlet.titleLabel?.text = "Sign in"
                nameTextField.isHidden = true
                
            }
            else{
                titleLabel.text = "Registration"
                loginButtonOutlet.titleLabel?.text = "to register"
                nameTextField.isHidden = false
                
            }
            
        }
    }
    
    
    
    @IBOutlet weak var isRegisterOutlet: UISwitch!
    
    
    @IBOutlet weak var haveAkkLabelOutlet: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // subscribe delegate
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        
        
        // becomefirstResponder
//        self.nameTextField.becomeFirstResponder()
//        self.passwordTextField.becomeFirstResponder()
//        self.emailTextField.becomeFirstResponder()
//        
        
        
        // move keyboard at display, when print information at textfield
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -20
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification , object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y  = 0.0
        }
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated)
        applyAuthVC()
        if  let _   = Auth.auth().currentUser {
            performSegue(withIdentifier: "Show", sender: self)
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    @IBAction func isRegisterAction(_ sender: Any) {
        if isRegisterOutlet.isOn {isReg = true} else {isReg = false }
    }
    
    
    @IBAction func loginButtonAction(_ sender: Any) {
        logOrReg()
        
    }
    
    
    
    
    func applyAuthVC()  {
        nameTextField.font = standardTextFont
        nameTextField.textColor = mainColor
        nameTextField.tintColor = headingTextColor
        
        
        passwordTextField.font = standardTextFont
        passwordTextField.textColor = mainColor
        passwordTextField.tintColor = headingTextColor
        
        emailTextField.font = standardTextFont
        emailTextField.textColor = mainColor
        emailTextField.tintColor = headingTextColor
        
        titleLabel.font? = registerTextFont
        titleLabel.textColor = headingTextColor
        
        loginButtonOutlet.titleLabel?.font = headlineFont
        loginButtonOutlet.titleLabel?.textColor = headingTextColor
        
        
        haveAkkLabelOutlet.font? = headlineFont
        haveAkkLabelOutlet.textColor = headingTextColor
        
        isRegisterOutlet.backgroundColor = backgroundColor
        isRegisterOutlet.tintColor = headingTextColor
        
        self.view.backgroundColor = backgroundColor
        
        
        
    }
    
    func logOrReg() {
        guard let name = nameTextField.text else{ return }
        guard let email = emailTextField.text else{return }
        guard let pass  = passwordTextField.text else {return}
        
        if isReg {
            if (!email.isEmpty && !pass.isEmpty) {
                Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
                    if error == nil {
                        self.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "Show", sender: nil)
                    }
                    else{showAlert(title: "Error", message: "Some Trobless with \(error?.localizedDescription) ", viewController: self)}
                }
                
            }
            else{
                showAlert(title: "Error", message:"Some Trobless  with write to textField ", viewController: self)
                
            }
        }
            
            
        else {
            if (!email.isEmpty && !pass.isEmpty && !name.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
                    if error == nil {
                        
                        if let result = result{
                            
                            let ref = Database.database().reference(withPath: "users")
                            let childByAutoIdRole =  ref.childByAutoId()
                            let uidRole = childByAutoIdRole.key
                            ref.child(result.user.uid).updateChildValues(["uid": result.user.uid, "name": name, "email" : email ,"uidRole": uidRole])
                            
                            
                            self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "Show", sender: nil)
                        }
                    }else{
                        showAlert(title: "Error", message:"Some Trobless with \(error?.localizedDescription) ", viewController: self)}
                }
                
            }
            else{
                showAlert(title: "Error", message:"Some Trobless  with write to textField ", viewController: self)
                
            }
        }
    }
}
extension AuthViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            emailTextField.resignFirstResponder()}
        
        if textField == nameTextField{
            nameTextField.resignFirstResponder()}
        if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            logOrReg()
        }
        return true
    }
    
}
