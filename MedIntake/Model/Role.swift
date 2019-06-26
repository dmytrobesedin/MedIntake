//
//  Role.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 6/3/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase

class Role {
    var uidRole: String?
    var nameRole: String?
    var link: DatabaseReference?

    
    init(_ snapshot: DataSnapshot) {
        self.uidRole = snapshot.value(forKey: "uidRole") as? String
        self.nameRole = snapshot.value(forKey: "nameRole") as? String
        self.link  = snapshot.ref
    }
}
