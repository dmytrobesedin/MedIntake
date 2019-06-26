//
//  Patient.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 13.05.2019.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase

class Patient: Human {

    var uid: String?
     var name: String?
    var email: String?
    var password: String?
    var uidRole:String?
    let link: DatabaseReference?
    
    init(_ snapshot: DataSnapshot) {
        self.uid = snapshot.value(forKey: "uid") as? String
        self.name = snapshot.value(forKey: "name") as? String
        self.email = snapshot.value(forKey: "email") as? String
        self.password = snapshot.value(forKey: "password") as? String
        self.uidRole = snapshot.value(forKey: "uidRole") as? String
        self.link  = snapshot.ref
    }
}
