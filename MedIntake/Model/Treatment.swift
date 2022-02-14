//
//  Treatment.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 12.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation

import Firebase


class Treatment {
    let uidTreatment: String?
    let illName: String?
    let description: String?
    let count: String?
    let startDate: Double?
    let endDate: Double?
    var intendedPills = [IntendedMedicine]()
    var link:  DatabaseReference?
    init(uid: String, illName: String,  description: String, count: String,startDate: Double,endDate: Double, pills: [IntendedMedicine]) {
        self.uidTreatment = uid
        self.illName = illName
        self.description = description
        self.count = count
        self.startDate = startDate
        self.endDate = endDate
        self.intendedPills  = pills
        
    }
    
    public init(_ snapShot: DataSnapshot) {
        let dict = snapShot.value as? [String: AnyObject]
        self.uidTreatment = dict?["uidTreatment"] as? String
        self.illName = dict?["illName"] as? String
        self.description = dict?["description"] as? String
        self.count = dict?["count"] as? String
        self.startDate = dict?["startDate"] as? Double
        self.endDate = dict?["endDate"] as? Double
      //  self.intendedPills = dict?["pillArray"] as? Array<IntendedMedicine> ??
        self.link = snapShot.ref
        
        
        
        
    }
    
}
