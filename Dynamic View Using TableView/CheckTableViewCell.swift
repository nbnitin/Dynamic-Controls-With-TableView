//
//  CheckTableViewCell.swift
//  Dynamic View Using TableView
//
//  Created by Nitin Bhatia on 11/08/17.
//  Copyright © 2017 Nitin Bhatia. All rights reserved.
//

import UIKit

class CheckTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var txt: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // Uncomment to add effect
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //        if selected {
    //            self.isHighlighted = true
    //        } else {
    //            self.isHighlighted = false
    //        }
    //
    //        // Configure the view for the selected state
    //    }
    //
    //    override var isHighlighted: Bool {
    //        get {
    //            return super.isHighlighted
    //        }
    //        set {
    //            if newValue {
    //                // you could put some animations here if you want
    //                UIView.animate(withDuration: 0.7, delay: 1.0, options: .curveEaseOut, animations: {
    //                    //self.txt.text = "select"
    //                    self.txt.alpha = 1.0
    //
    //                }, completion: { finished in
    //                    print("select")
    //                })
    //            }
    //            else {
    //                self.txt.alpha = 0.6
    //            }
    //            super.isHighlighted = newValue
    //        }
    //    }
    
}
