//
//  AddPillsTableViewController.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 5/27/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit
import Firebase


class AddPillsTableViewController: UITableViewController {

    @IBOutlet weak var photoPills: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameLabelOtlet: UILabel!
    
    @IBOutlet weak var dateOfStartPills: UITextField!
    @IBOutlet weak var descriptionOutlet: UITextField!
    @IBOutlet weak var descriptionLabelOutlet: UILabel!
    @IBOutlet weak var countOutlet: UITextField!
    @IBOutlet weak var countLabelOutlet: UILabel!
    @IBOutlet weak var dateOfStartLabelOutlet: UILabel!
    
    @IBOutlet weak var pillsDatePicker: UIDatePicker!
    
    @IBOutlet weak var InTake: UISwitch!
  
    @IBOutlet weak var intakeLabelOutlet: UILabel!
    
    
    var isIntake = false
    var dateTimeInterval: TimeInterval = 0
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subscribe delegate
        
        nameTextField.delegate = self
        descriptionOutlet.delegate = self
        countOutlet.delegate = self
        
        
        
        applyStyleTextField()
        
        
        
        // move keyboard at display, when print information at textfield
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -25.0
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification , object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y  = 0.0
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewCellTheme(indentifire: "photoCell")
        tableViewCellTheme(indentifire: "nameCell")
        tableViewCellTheme(indentifire: "descriptionCell")
        tableViewCellTheme(indentifire: "countCell")
        tableViewCellTheme(indentifire: "DateStartCell")
        tableViewCellTheme(indentifire: "intakeCell")
    }
    
    func applyStyleTextField()  {
        imagePicker.view.backgroundColor = backgroundColor
        
        nameTextField.font = standardTextFont
        nameTextField.textColor = mainColor
        nameTextField.tintColor = headingTextColor
        
        nameLabelOtlet.font? = headlineFont
        nameLabelOtlet.textColor = headingTextColor
        
        descriptionOutlet.font = standardTextFont
        descriptionOutlet.textColor = mainColor
        descriptionOutlet.tintColor = headingTextColor
        
        descriptionLabelOutlet.font? = headlineFont
        descriptionLabelOutlet.textColor = headingTextColor
        
        countOutlet.font = standardTextFont
        countOutlet.textColor = mainColor
        countOutlet.tintColor = headingTextColor
        
        countLabelOutlet.font? = headlineFont
        countLabelOutlet.textColor = headingTextColor
        
        dateOfStartPills.font = standardTextFont
        dateOfStartPills.textColor = mainColor
        dateOfStartPills.tintColor = headingTextColor
        
        dateOfStartLabelOutlet.font? = headlineFont
        dateOfStartLabelOutlet.textColor = headingTextColor
        
        
        pillsDatePicker.backgroundColor = backgroundColor
        
        intakeLabelOutlet.font? = headlineFont
        intakeLabelOutlet.textColor = headingTextColor
        
        InTake.backgroundColor = backgroundColor
        InTake.tintColor = headingTextColor
        
        self.view.backgroundColor = backgroundColor
        
    
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameTextField.resignFirstResponder()
        self.pillsDatePicker.resignFirstResponder()
        self.descriptionOutlet.resignFirstResponder()
        self.countOutlet.resignFirstResponder()
         self.view.endEditing(true)
        
    }

     

    
    func tableViewCellTheme(indentifire: String){
    let cell = self.tableView.dequeueReusableCell(withIdentifier:indentifire)
        cell?.contentView.backgroundColor = backgroundColor
        cell?.backgroundColor = backgroundColor
        cell?.backgroundView?.backgroundColor  = backgroundColor
        cell?.tintColor = backgroundColor
        cell?.textLabel?.tintColor = backgroundColor
        cell?.textLabel?.font = standardTextFont
        cell?.textLabel?.textColor = mainColor

    
    }
    @IBAction func saveAction(_ sender: Any) {
        guard let name = nameTextField.text else{return}
        guard let description = descriptionOutlet.text else{return}
        guard let count = countOutlet.text else{return}
        guard let dateOfStartPillTextfield = dateOfStartPills.text else{return}
        
        if ( !name.isEmpty && !description.isEmpty && !count.isEmpty && !dateOfStartPillTextfield.isEmpty) {
            var data = Data()
            if let image = photoPills.image {
                if let  dataIn = image.jpegData(compressionQuality: 0.1){
                    data = dataIn
                }else{print("torbless with dataIn")}
            }
            let ref = Database.database().reference(withPath: "users")
            let base64String = data.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
            
            guard let  uid  = Auth.auth().currentUser?.uid else {return}
            let baseRefPills = ref.child(uid).child("pills").childByAutoId()
            let uidPills = baseRefPills.key
            let newPills: [String: Any] = [ "uidPill": uidPills, "name":name, "userUid": uid,"description": description,"count": count, "dateStart": dateTimeInterval,"photo": base64String, "intake": isIntake]
            
            baseRefPills.setValue(newPills)
            self.dismiss(animated: true, completion: nil)
        }
        else{
            showAlert(title: "Error", message:"Some Trobless  with write to textField ", viewController: self)
            
        }
        
    }
    
    @IBAction func intakeAction(_ sender: Any) {
        if InTake.isOn {isIntake = true}
        else{isIntake = false}
    }
    
    
    @IBAction func backClicker(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    
    @IBAction func datePicker(_ sender: AnyObject) {
        dateTimeInterval = pillsDatePicker.date.timeIntervalSinceNow
        dateOfStartPills.text  = formatDate(date: pillsDatePicker.date)
        
    }
  
    

   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
      
        
        let alertVC = UIAlertController(title: "Some question", message: "You choose camera or PhotoLibrary", preferredStyle: .alert)
            let camera = UIAlertAction(title: "Camera", style: .default) { (_)  in
                self.imagePicker = UIImagePickerController()
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: false, completion: nil)
            }
            let photoLibrary = UIAlertAction(title: "PhotoLibrary", style: .default) { (_)  in
                
                self.imagePicker = UIImagePickerController()
                self.imagePicker.allowsEditing = false
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = .photoLibrary
                
                
                self.present(self.imagePicker, animated: false, completion: nil)
            }
            alertVC.addAction(camera)
            alertVC.addAction(photoLibrary)
            present(alertVC, animated: true, completion: nil)

        }
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}


extension AddPillsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        imagePicker.dismiss(animated: true, completion: nil)
        photoPills.image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField{
            self.nameTextField.resignFirstResponder()}
        if textField == descriptionOutlet{
            self.descriptionOutlet.resignFirstResponder()}
        if textField == countOutlet{
            self.countOutlet.resignFirstResponder()}
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == countOutlet {
            let allowedCharacters = CharacterSet(charactersIn:".,0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
