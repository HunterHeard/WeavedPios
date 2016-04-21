//
//  Pin.swift
//  Attempt2
//
//  Created by Hunter Heard on 3/31/16.
//  Copyright (c) 2016 Hunter Heard. All rights reserved.
//

import UIKit


class Pin {
    
    // MARK: Properties
    
    //Each pin needs the following
    // Type: Control, Monitor, or Ignore
    // Name
    // Name of High
    // Name of Low
    
    
    var name: String
    
    var Hname: String
    var Lname: String
    var stateName: String
    var type: Int
    
    var on: Bool
    
    
    // MARK: Initialization
    
    init(name: String, Hname: String, Lname: String, type: Int) {
        
        self.name = name;
        self.Hname = Hname;
        self.Lname = Lname;
        self.type = type;
        self.stateName = Lname;
        
        
        self.on = false;
        
        
    }
    
    init() {
        
        self.name = "label";
        self.Hname = "On";
        self.Lname = "Off";
        self.type = 0;
        self.stateName = "Off";
        
        
        self.on = false;
        
        
    }
    
    func changeState()
    {
        if(on)
        {
            on = false;
            stateName = Lname;
            return;
        }
        
        on = true;
        stateName = Hname;
        return;
    }
    
    func changeType()
    {
        type++;
        
        if(type > 2)
        {
            type = 0;
        }
        
        
    }
    
    
    func setName(newName: String)
    {
        name = newName;
    }
    
    func setHname(newName: String)
    {
        Hname = newName;
    }
    
    func setLname(newName: String)
    {
        Lname = newName;
    }
    
    
    
    func getEmpty() -> [Pin]
    {
        var pins = [Pin]();
        
        var p = Pin(name: "label", Hname: "On", Lname: "Off", type: 0);
        
        for i in 1...16
        {
            pins += [p];
        }
        
        
        return pins;
        
        
        
    }
    
    
}
