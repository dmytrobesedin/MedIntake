//
//  User .swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 12.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase


class User {
    var uidUser: String?
    var name: String
    var email: String
    var password: String
    var link: DatabaseReference?
    
    init(_ snapshot: DataSnapshot) {
        self.uidUser = snapshot.value(forKey: "uidUser") as? String
        self.name = snapshot.value(forKey: "name") as? String ?? ""
        self.email = snapshot.value(forKey: "email") as? String ?? ""
        self.password = snapshot.value(forKey: "password") as? String ?? ""
        self.link = snapshot.ref

    }
    init(uid: String, name: String, email:String, password: String) {
        self.uidUser = uid
        self.name = name
        self.email = email
        self.password = password

    }
}
