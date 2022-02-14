//
//  ViewController.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 25.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import UIKit
import Firebase
class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        //test1()
       let intendedPilll =  IntendedMedicine(aPill: Pill(uidPill: "test", name: "test", description:"test" , photo: "test"), aCount: "test", aStartDate: 0.0, anIsIntake: false, uidPill: "test", name: "test", description: "test", photo: "test")
  
        print("TEST1!!!!\(intendedPilll.isIntake)")
        print("TEST!2!!!\(intendedPilll.uidPill)")
        print("TEST!!3!!\(intendedPilll.pill)")
        print("TEST!!!3!\(intendedPilll.name)")
        
        
    }
    
    
    
    func test1()  {
   
        let ref = Database.database().reference(withPath: "users")
            let autoId = ref.childByAutoId()
        let key  = autoId.key
      //  let base64String = data.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
       // guard let  uid  = Auth.auth().currentUser?.uid else {return}
     //   let baseRefPills = ref.(uid).child("pillschild").childByAutoId()
       // let uidPills = baseRefPills.key
        
        
     
        let newPills: [String: Any] = [ "pill": "pill" , "count":"test1", "starDate":0.0,"isIntake": false, "key": key ]
     //   IntendedMedicine(snapShot: <#T##DataSnapshot#>, completionHandler: <#T##(IntendedMedicine?) -> Void#>)
        autoId.setValue(newPills)
        
    }
    
    
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
