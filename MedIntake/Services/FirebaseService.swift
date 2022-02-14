//
//  FIrebaseService .swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 08.02.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    
    private let auth = Auth.auth()
    private let refUsers = Database.database().reference(withPath: "users")
   
    

    public   func signUpUser(name: String, email:String, pass: String,  handler: @escaping (_ error: Error?) -> ())  {
        
        auth.createUser(withEmail: email, password: pass) { result, error in
            
            
            
            
            switch result {
            case .some(_):
                guard let result = result else {return}
                self.refUsers.child(result.user.uid).updateChildValues(["uid": result.user.uid, "name": name, "email" : email ])
                handler( nil)
            case .none:
               
                handler(error )
            }
        }
        
    }
 public   func signInUser(email:String, pass: String,  handler: @escaping (  _ error: Error?) -> () ) {
        auth.signIn(withEmail: email, password: pass) { (result, error) in
            switch result {
            case .some(_):
                handler( nil)
            case .none :
                handler( error)
            }
        }
    }
    public     func loadPillFromFirebase(handler: @escaping ( _ snapshot: DataSnapshot?,  _ error: Error?) -> ())  {
        //
        

       
        guard let  uidUser  = auth.currentUser?.uid else {return}
        refUsers.child(uidUser).child("pills").queryOrdered(byChild:"intake").observe(.value) { datasnashot in
            handler(datasnashot, nil)
        } withCancel: { error in
            handler(nil, error)
        }

      
        
    }
    public func addPillToFirebase(name:String,description:String,count: String, dateTimeInterval: TimeInterval, photo:String, isIntake: Bool ) {
      
        guard let  uidUser  = Auth.auth().currentUser?.uid else {return}
        let baseRefPills = refUsers.child(uidUser).child("pills").childByAutoId()
        let uidPill = baseRefPills.key
        
        let newPills: [String: Any] = [ "uidPill": uidPill, "name":name, "userUid": uidUser,"description": description,"count": count, "dateStart": dateTimeInterval,"photo": photo, "intake": isIntake]
        
       
        baseRefPills.setValue(newPills)
    }
}

