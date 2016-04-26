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
    var function: Bool
    
    
    
    
    //type 0: Ignore
    //type 1: Control
    //type 2: Monitor
    
    var on: Bool
    
    
    // MARK: Initialization
    
    init(name: String, Hname: String, Lname: String, type: Int) {
        
        self.name = name;
        self.Hname = Hname;
        self.Lname = Lname;
        self.type = type;
        self.stateName = Lname;
        self.function = false;
        
        if(type == 1)
        {
            self.function = true;
        }
        
        self.on = false;
        
        
    }
    
    init() {
        
        self.name = "label";
        self.Hname = "On";
        self.Lname = "Off";
        self.type = 0;
        self.stateName = "Off";
        self.function = false;
        
        self.on = false;
        
        
    }
    
    func typeFunction(t: Int) -> Bool
    {
        if(t == 1)
        {
            return true;
        }
        
        if(t == 2)
        {
            return false;
        }
        
        if(t == 0)
        {
            return false;
        }
        
        return false;
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
    
    func setFromData(data: NSDictionary)
    {
        println("\nPin setting data from outside");
        
        on = data.valueForKey("value") as Bool;
        print("Value set to ");
        stateName = Lname;
        
        if(on)
        {
            stateName = Hname;
        }
        
        println(stateName);
        
        var t = data.valueForKey("function") as String;
        
        if(t == "IN")
        {
            type = 2;
        }
        
        if(t == "OUT")
        {
            type = 1;
        }
        
        typeFunction(type);
        
        print("Type set to ");
        println(type);
        return;
        
    }
    
    func changeType()
    {
        type++;
        
        if(type > 2)
        {
            type = 0;
        }
        
        function = typeFunction(type);
        
        
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
    
    
    
    class func getEmpty() -> [Pin]
    {
        var pins = [Pin]();
        
        var p = Pin(name: "label", Hname: "On", Lname: "Off", type: 0);
        
        for i in 1...16
        {
            p = Pin(name: "label", Hname: "On", Lname: "Off", type: 0);//without this line, pins will be an array full of references to the same one pin
            pins += [p];
        }
        
        
        return pins;
        
        
        
    }
    
    
}
