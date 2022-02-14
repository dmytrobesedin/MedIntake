//
//  ViewControllerHelper.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 27.01.2022.
//  Copyright © 2022 DmytroBesedin. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerHelper {
    
    
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
    
    
}
