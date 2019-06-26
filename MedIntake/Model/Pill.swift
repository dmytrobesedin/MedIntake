//
//  Pill.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 5/28/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation
import  Firebase


class Pill{
    var uidPill:String?
    var name:String?
    var userUid:String?
    var description: String?
    var count: String?
    var startDate: Double?
    var photo: String?
    var isIntake:Bool?
    var ref: DatabaseReference?
    
    init(snapShot: DataSnapshot) {
       let dict = snapShot.value as? [String: AnyObject]
        self.uidPill = dict?["uidPill"] as? String
        self.name = dict?["name"] as? String
        self.userUid = dict?["userUid"] as? String
        self.description = dict?["description"] as? String
        self.count = dict?["count"] as? String
        self.startDate = dict?["dateStart"] as? Double
        self.photo = dict?["photo"] as? String
        self.isIntake = dict?["intake"] as? Bool
        self.ref = snapShot.ref
        
    }

}
