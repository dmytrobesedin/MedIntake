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
    let uidPill:String?
    var name:String?
    var description: String?
    var photo: String?
    var isChecked: Bool = false
    var ref: DatabaseReference?
    //для кажой модели с фарейбозом класс firebasePill
   public init(_ snapShot: DataSnapshot) {
        let dict = snapShot.value as? [String: AnyObject]
        self.uidPill = dict?["uidPill"] as? String
        self.name = dict?["name"] as? String
        self.description = dict?["description"] as? String
        self.photo = dict?["photo"] as? String
        self.ref = snapShot.ref
    
    
    
    
    }
    
    init(uidPill: String, name: String, description:String, photo: String) {
        self.uidPill = uidPill
        self.name = name
        self.description = description
        self.photo = photo
    }
//    required init(coder aDecoder: NSCoder) {
//          fatalError("init(coder:) has not been implemented")
//      }
}
