//
//  RadioTableViewCell.swift
//  Dynamic View Using TableView
//
//  Created by Nitin Bhatia on 11/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class RadioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var txt: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
