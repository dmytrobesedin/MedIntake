//
//  Patient.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 13.05.2019.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase

// user
class Patient: User {

 
 //   let user : User
 //   var uidRole:String?
 //   let link: DatabaseReference?
    var uidPatient: String?
    var treatment =  [Treatment]()
    var reports =  [Report]()
    
    
    
    
    
     init(snapshot: DataSnapshot ){
        super.init(snapshot)
        self.uidPatient = snapshot.key
        self.treatment = snapshot.value(forKey: "treatments") as? [Treatment] ?? [Treatment]()
        self.reports = snapshot.value(forKey: "reports") as? [Report] ?? [Report]()
    }
    
 
    init(uid: String, name: String, email: String, password: String, uidPatient: String ) {
        super.init(uid: uid, name: name, email: email, password: password)
        self.uidPatient = uidPatient
        
    }
    
}
