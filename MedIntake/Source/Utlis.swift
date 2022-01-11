//
//  Utlis.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 5/28/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import Foundation
import UIKit

// то же самое, создать отдельный класс для этогоё

//func formatDate(date: Date) -> String
//{
//    let dateFormatter = DateFormatter()
//   dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//   // dateFormatter.dateFormat = "MMM d, HH:mm"
//  //  dateFormatter.timeStyle = .short
//   // dateFormatter.dateStyle = .short
//    dateFormatter.locale = Locale(identifier: "uk_UA")
//
//    let dateString = dateFormatter.string(from: date )
//    return dateString
//    
//} // сделать класс DateFormattingHelper и доабвить туда эти две функции
//
//func formatString(string:String) -> Date {
//
//let dateFormatter = DateFormatter()
//dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//dateFormatter.locale = Locale(identifier: "uk_UA")
////dateFormatter.dateFormat = "yyyy-MM-dd"
//   
//    if let stringDate = dateFormatter.date(from: string){
//        return stringDate
//    }
//    return Date()
//}
//
//// сделать класс AlertPresenter и доабвить туда эту функцию
//
//func showAlert(title:String,message:String,viewController: UIViewController)  {
//    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//    viewController.present(alert, animated: false, completion: nil)
//}
//    
