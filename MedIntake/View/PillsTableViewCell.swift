//
//  PillsTableViewCell.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 6/1/19.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit

class PillsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    func refresh(model: Pill){
        textLabel?.text = model.name
        detailTextLabel?.text = model.description

    }
  
}
