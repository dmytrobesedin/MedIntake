//
//  DateFormatterHelper.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 11.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation
class DateFormatterHelper{
    
    func formatDate(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
       // dateFormatter.dateFormat = "MMM d, HH:mm"
      //  dateFormatter.timeStyle = .short
       // dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "uk_UA")

        let dateString = dateFormatter.string(from: date )
        return dateString
        
    } // сделать класс DateFormattingHelper и доабвить туда эти две функции

    func formatString(string:String) -> Date {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    dateFormatter.locale = Locale(identifier: "uk_UA")
    //dateFormatter.dateFormat = "yyyy-MM-dd"
       
        if let stringDate = dateFormatter.date(from: string){
            return stringDate
        }
        return Date()
    }
}
