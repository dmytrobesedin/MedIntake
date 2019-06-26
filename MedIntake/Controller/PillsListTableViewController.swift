//
//  PillsListTableViewController.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 5/27/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
import  UserNotifications

class PillsListTableViewController: UITableViewController {
    
    @IBOutlet weak var reportButtonOutlet: UIBarButtonItem!
    
    var pills = [Pill]()
    var emailSender = ""
    var fileName = "Report1"
    var messageBody = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDateFromFirebase()
        fileName = randomString(length: 8)
        notificationPill()
     
        
        

        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createMailAtSend()
        createMessageBox()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pills.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PillsListCell", for: indexPath)
        
        let pillsList = pills[indexPath.row]
        
        configureCell(cell: cell, indexPath: indexPath)
        if let isIntakePills = pillsList.isIntake {
            
            cellCheckbox(cell: cell, isIntake: isIntakePills)}
        tableViewCell(cell: cell)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            // find snapshot and remove value
            let pillsList = pills[indexPath.row]
            pillsList.ref?.removeValue()
            pills.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
        
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let complete = comleteAction(at: indexPath, tableView: tableView)
        return UISwipeActionsConfiguration(actions: [complete])
    }
    fileprivate func notificationPill() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.sound = UNNotificationSound.default
        //  content.threadIdentifier = "local-notification ttemp"
        
        let ref2 = Database.database().reference(withPath: "users")
        
        guard let uidUser2  = Auth.auth().currentUser?.uid else { return }
        ref2.child(uidUser2).child("pills").observe(.value) { (snapshot) in
            for list in snapshot.children{
                if let listLoop = list as? DataSnapshot{
                    let pillsList = Pill(snapShot: listLoop)
                    if let istake = pillsList.isIntake{
                        if istake == false{
                            
                  
                            if let namePill = pillsList.name {
                                if let desc = pillsList.description{
                                    if let count = pillsList.count{
                                        content.title = "Hello, you have intake: \(namePill)"
                                        content.subtitle = "Rule- \(desc), count - \(count) "
                                        
                                        
                                        if let timeInterval = pillsList.startDate{
                                            
                                            let date = Date(timeIntervalSinceNow: timeInterval)
                                            let georgian = Calendar(identifier: .gregorian)
                                            let dateComponent = georgian.dateComponents([.year,.day, .month, .hour, .minute], from: date)
                                            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
                                            let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
                                            center.add(request) { (error) in
                                                if error != nil{
                                                    print(error?.localizedDescription)
                                                }
                                            }
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func comleteAction(at indexPath: IndexPath, tableView: UITableView) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Intake") { (action, view, completion) in
            guard let cell = tableView.cellForRow(at: indexPath) else {return}
            let pillsList = self.pills[indexPath.row]
            
            if let switchToggle = pillsList.isIntake{
                let toggle = !switchToggle
                self.cellCheckbox(cell: cell, isIntake: toggle)
                
                pillsList.isIntake = toggle
                
                self.pills[indexPath.row] = pillsList
                pillsList.ref?.updateChildValues(["intake": toggle])
                tableView.reloadData()
            }
            completion(true)
        }
        
        let pillsList = self.pills[indexPath.row]
        let switchToggle = pillsList.isIntake
        action.image = UIImage(named:"Check")
        if switchToggle == false{
            action.backgroundColor = .green
            return action
        }
        else{
            action.backgroundColor = .red
            return action
        }
        
    }
    
    func convertBase64ToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
    
    
    
    
    // MARK: Configure Cell
    func configureCell(cell:UITableViewCell, indexPath: IndexPath ){
        let pillsList = pills[indexPath.row]
        cell.textLabel?.text = pillsList.name
        if  let dateStart = pillsList.startDate{
            convertTimeInterval(cell: cell, timeInterval: dateStart)}
        
        if let base64String = pillsList.photo {
            convertImage(cell: cell, imageString: base64String)
        }
        
        
    }
    
    // MARK: cellCheckBox
    func cellCheckbox(cell: UITableViewCell, isIntake: Bool){
        if !isIntake{
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.textLabel?.textColor = UIColor.black
            cell.detailTextLabel?.textColor = UIColor.black
        }
        else{
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            cell.textLabel?.textColor = UIColor.gray
            cell.detailTextLabel?.textColor = UIColor.gray
        }
    }
    
    
    
    
    // MARK: = Convert TimeInterval
    func convertTimeInterval(cell:UITableViewCell, timeInterval: TimeInterval){
        let date = Date(timeIntervalSinceNow: timeInterval)
        let dateString = formatDate(date: date )
        
        cell.detailTextLabel?.text = dateString
    }
    
    
    
    func convertTimeIntervalInString(timeInterval: TimeInterval) ->  String{
        let date = Date(timeIntervalSinceNow: timeInterval)
        let dateString = formatDate(date: date )
        
        return dateString
    }
    
    
    
    // MARK: = Convert Image
    
    func convertImage(cell:UITableViewCell,imageString:String){
        guard  let decodedDate = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) else{return}
        guard let decodedImage = UIImage(data: decodedDate) else {return}
        cell.imageView?.image = decodedImage
        
    }
    func convertImageTImage(imageString:String) -> UIImage {
        if  let decodedDate = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters){
            if let decodedImage = UIImage(data: decodedDate){
                return decodedImage
            }
            
        }
        return UIImage()
    }
    
    
    //MARK: Appply TableVIewStyle
    //MARK: - Apply TableViewCell Style
    
    func tableViewCell(cell: UITableViewCell) {
        cell.contentView.backgroundColor = backgroundColor
        cell.backgroundColor = backgroundColor
        
        cell.textLabel?.font = headlineFont
        cell.textLabel?.textColor = headingTextColor
        cell.textLabel?.backgroundColor = backgroundColor
        
        cell.detailTextLabel?.font = subtitleFont
        cell.detailTextLabel?.textColor = subtitleTextColor
        cell.detailTextLabel?.backgroundColor = backgroundColor
    }
    
    // MARK: Reload DateBase
    func loadDateFromFirebase()  {
        //
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let ref = Database.database().reference(withPath: "users")
        guard let  uidUser  = Auth.auth().currentUser?.uid else {return}
        ref.child(uidUser).child("pills").queryOrdered(byChild:"intake").observe(DataEventType.value, with: { (snapshot) in
            
            
            var newPillsList = [Pill]()
            
            for list in snapshot.children{
                if let listLoop = list as? DataSnapshot{
                    
                    let pillsList = Pill(snapShot: listLoop)
                    
                    newPillsList.append(pillsList)
                }
            }
            self.pills = newPillsList
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    @IBAction func sendReportAction(_ sender: Any) {
//        reportButtonOutlet.target = self
//
//        reportButtonOutlet.action = #selector(createMessageBox)
//        reportButtonOutlet.action = #selector(createMailAtSend)
//
//
//        createMessageBox()
//         createMailAtSend()
        

        convertFile(messageBody, fileName: fileName)
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Can't send email")
        }
        
    }
    func createReport()  {
        let refBase = Database.database().reference(withPath: "users")
        guard let  uidPerson  = Auth.auth().currentUser?.uid else {return}
        
        let childId =   refBase.child(uidPerson).child("reports").childByAutoId()
        let key = childId.key
        let newReport: [String: Any] = [ "fileName":self.fileName,"text": messageBody, "uidReport": key, "userUid": uidPerson]
        childId.setValue(newReport)
    }


@objc    func createMailAtSend() {
        var  loopString = ""
        let ref2 = Database.database().reference(withPath: "users")
        
        guard let uidUser2  = Auth.auth().currentUser?.uid else { return }
        ref2.child(uidUser2).observe(.value) { (snapshot) in
            if let dict = snapshot.value as? [String: Any] {// the value is a dict
                
                loopString = dict["email"] as? String ?? "email"
                //   print("\(loopString) loves eeeee")
                
                self.emailSender = loopString
            }
            
        }
        
        
    }
    
@objc    func createMessageBox(){
        var loopString = ""
        let ref2 = Database.database().reference(withPath: "users")
        
        guard let uidUser2  = Auth.auth().currentUser?.uid else { return }
        ref2.child(uidUser2).child("pills").observe(.value) { (snapshot) in
            for list in snapshot.children{
                if let listLoop = list as? DataSnapshot{
                    
                    let pillsList = Pill(snapShot: listLoop)
                    loopString += "Name - "
                    loopString += pillsList.name  ?? "Name"
                  
                    
                    loopString.append(", ")
                    loopString += "description - "
                    loopString += pillsList.description  ?? "descript"
         
                    loopString.append(", ")
                    loopString += "date Intake - "
                    if let timeInterval = pillsList.startDate  {
                        loopString += self.convertTimeIntervalInString(timeInterval: timeInterval)
                        loopString.append(", ")
                        loopString += "Intake - "
                        if let istaken = pillsList.isIntake{
                            loopString += self.isIntake(sender: istaken)
                            loopString.append(".")
                            loopString.append("\n")
                            
                            self.messageBody = loopString
                            
                            
                            
                            
                        }
                        
                    }
                }
            }
        }
        
        
        
        
    }
    func convertFile(_ string: String, fileName: String)  {
        
        let fileNameLoop = "\(fileName).txt"
        let path = (NSTemporaryDirectory() as NSString).appendingPathComponent(fileNameLoop)
        do {
            try string.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            
        }
    }
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    func isIntake(sender: Bool) -> String {
        if sender {
            return "pass"
        }
        else {
            return "fail"
        }
    }
    // MARK: - ConfigureMail
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setSubject("Pill Report")
        mailComposeVC.setToRecipients([emailSender])
        
        if let data = (messageBody as String).data(using: String.Encoding.utf8){
            //Attach File
            mailComposeVC.addAttachmentData(data, mimeType: "text/plain", fileName: fileName)
        }
        mailComposeVC.setMessageBody("Hello, this is .txt report about pills intake", isHTML: false)
        return mailComposeVC
    }
    @IBAction func LogOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController")
            UIApplication.shared.keyWindow?.rootViewController = VC
            self.dismiss(animated: false, completion: nil)
        }catch {
            print(error)
        }
        
        
    }
}
extension PillsListTableViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: false, completion: nil)
        createReport()
    }
   
}
