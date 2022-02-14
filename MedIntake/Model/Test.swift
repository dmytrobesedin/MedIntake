//
//  File.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 29.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation
import Firebase


class Test {

        var city: String?
    var boolTest: Bool = false
        var link: DatabaseReference?
        
        init(_ snapshot: DataSnapshot) {
            let dict = snapshot.value as? [String: AnyObject]
            self.city = dict?["city"]  as? String
            self.link = snapshot.ref

        }
}
