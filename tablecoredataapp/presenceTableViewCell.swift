//
//  presenceTableViewCell.swift
//  tablecoredataapp
//
//  Created by gulam ali on 15/09/17.
//  Copyright © 2017 gulam ali. All rights reserved.
//

import UIKit

class presenceTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bgimage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    
    @IBOutlet weak var item: UILabel!
   
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
