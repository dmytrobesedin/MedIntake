//
//  IntendedMedicine.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 12.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase
class IntendedMedicine: Pill {
    var uidIntendedMedicine: String?
    var pill: Pill?
    var count: String?
    var startDate: Double?
    var isIntake: Bool?
    
    
    // var link = Database.database().reference(withPath: "users")
    init(snapShot: DataSnapshot, completionHandler: @escaping (IntendedMedicine?)-> Void) {
        super.init(snapShot)
        self.uidIntendedMedicine = snapShot.key
        
        getFirebasePillURL {  pill in
         //   guard let self = self else {return}
            //  guard let self = self else{return}
            self.pill = pill
            
            
            
            let dictionary = snapShot.value as? [String: AnyObject]
            //  self.pill = pill //
            self.count = dictionary?["count"] as? String ?? ""
            self.startDate = dictionary?["startDate"] as? Double ?? 0.0
            self.isIntake = dictionary?["isIntake"] as? Bool ?? false
            
            completionHandler(self)
        }
       
    }
    
    
    
 
    
    init(aPill: Pill, aCount: String, aStartDate: Double, anIsIntake: Bool, uidPill: String, name: String, description:String, photo: String) {
        super.init(uidPill: uidPill , name: name , description: description , photo: photo )
        self.pill = aPill
        self.count  = aCount
        self.startDate  = aStartDate
        self.isIntake = anIsIntake
     
    }
//
//        required init(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//
    
    
    
    
    private func getFirebasePillURL(completion: @escaping (_ pill: Pill) -> Void)  {
        guard let currentUser = Auth.auth().currentUser?.uid else{return}
        //var newPillsList = [Pill]()
        let pillRef = Database.database().reference(fromURL: "users").child(currentUser).child("pills") // add uid intended pill
        
        pillRef.observeSingleEvent(of: .value) { snapshot in
            guard let pill = snapshot.value as? Pill else{return}
            completion(pill)
        }
        
    }
}
