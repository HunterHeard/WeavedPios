//
//  ListTableViewCell.swift
//  Attempt2
//
//  Created by Hunter Heard on 4/15/16.
//  Copyright (c) 2016 Hunter Heard. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var aliasLabel: UILabel!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var devLogButton: UIButton!
    
    @IBAction func devButtonPress(sender: UIButton) {
        
        
        spinner.startAnimating();
        
        //lock all other buttons
        //start rotating thing
        //attempt to login to the device
        //finish attempt
        //stop rotating thing
        //unlock all buttons
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setName(name: String)
    {
        aliasLabel.text = name;
    }
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
