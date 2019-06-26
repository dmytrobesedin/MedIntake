//
//  Doctor.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 13.05.2019.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation
import  Firebase

class Doctor: Human {

    var name: String?
    var email: String?
    var password: String?
    let link: DatabaseReference?
 

    init(snapshot: DataSnapshot) {
        self.name = snapshot.value(forKey: "name") as? String
        self.email = snapshot.value(forKey: "email") as? String
         self.password = snapshot.value(forKey: "password") as? String
        self.link  = snapshot.ref
    }
}
