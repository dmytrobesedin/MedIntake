//
//  AuthViewPresenter.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 10.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth


protocol AuthViewProtocol: NSObjectProtocol  {
    func performToMainScreen()
    func showAlertMessage(title:String,message:String)
    
}

class AuthViewPresenter {
    public var name: String?
    public var email: String?
    public var pass: String?
    weak var authView: AuthViewProtocol?
    //        init(name: String,email: String, pass: String, view: AuthViewProtocol) {
    //            self.name = name
    //            self.email = email
    //            self.pass = pass
    //            self.authView = view
    //        }
    init(view: AuthViewProtocol) {
        self.authView = view
    }
    public   func signUpUser(name: String, email:String, pass: String) {
        Auth.auth().createUser(withEmail: email, password: pass) { (result, error) in
            if error == nil {
                if let result = result{
                    let ref = Database.database().reference(withPath: "users")
                    let childByAutoIdRole =  ref.childByAutoId()
                    let uidRole = childByAutoIdRole.key
                    ref.child(result.user.uid).updateChildValues(["uid": result.user.uid, "name": name, "email" : email ,"uidRole": uidRole])
                    self.authView?.performToMainScreen()
                }
            }
            else{
                guard let errorLocalizedDescription = error?.localizedDescription else{return}
                self.authView?.showAlertMessage(title:error.debugDescription, message:errorLocalizedDescription)
            }
        }
        
    }
    //
    public  func signInUser(email:String, pass: String){
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if error == nil {
                self.authView?.performToMainScreen()
            }
            else{
                self.authView?.showAlertMessage(title: error.debugDescription, message: error.debugDescription)
            }
        }
    }
}

