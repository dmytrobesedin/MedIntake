//
//  Report.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 5/31/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase
class Report {
    
    var fileName: String?
    var text: String?
    var uidReport: String?
    var uidUser: String?
    let link: DatabaseReference?
    
    init(_ snapshot: DataSnapshot) {
        self.fileName = snapshot.value(forKey: "fileName") as? String
        self.text = snapshot.value(forKey: "text") as? String
        self.uidUser = snapshot.value(forKey: "userUid") as? String
        self.uidReport = snapshot.value(forKey: "uidReport") as? String
        self.link  = snapshot.ref
    }
}
