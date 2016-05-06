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
    
    @IBOutlet weak var userNameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    var loggedIn = false;
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var devLogButton: UIButton!
    
    @IBAction func devButtonPress(sender: UIButton) {
        
        
        //spinner.startAnimating();
        
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
    
    func setLog(logged: Bool)
    {
        loggedIn = logged;
        
        if(logged)
        {
            devLogButton.setTitle("L-Out", forState: UIControlState.Normal);
            backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3);
            return;
        }
        
        
        devLogButton.setTitle("Login", forState: UIControlState.Normal);
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3);


        
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
