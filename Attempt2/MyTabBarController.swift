//
//  MyTabBarController.swift
//  Attempt2
//
//  Created by Hunter Heard on 3/31/16.
//  Copyright (c) 2016 Hunter Heard. All rights reserved.
//

import UIKit
import Foundation

class MyTabBarController: UITabBarController {

    
    //MARK Properties
    var tabCount = 0;
    var tabBarPins = [Pin]();
    
    var testValue = 5;
    
    var ipaddress = "";
    
    var devProxy = "";
    
    var session = NSURLSession();
    
    var weavedToken = "";
    
    var webioPiLogged = false;
    
    var raspberryDevice = NSObject();
    
    var base64LoginString = NSString();

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print("loading Tab Bar Controller\n");
        
        
        tabBarPins = Pin.getEmpty();
        
        
        //getIP();

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getIP() -> String
    {
        if(ipaddress != "")
        {
            return ipaddress;
        }
        
        if(ipaddress == "-1")
        {
            print("IP address still waiting...");
            return ipaddress;
        }
        
        setIP();
        
//        let url = NSURL(string: "http://ip.42.pl/raw");
//        
//        let request = NSMutableURLRequest(URL:url!);
//        request.HTTPMethod = "GET";
//        var response: NSURLResponse?
//        var reponseError: NSError?
//
//        var urlData = NSData();
//        //crashes here
//        do
//        {
//            urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response);
//        }
//        catch
//        {
//            print("IP get failed");
//            ipaddress = "";
//            return "";
//        }
//        
//        
//        let ip = NSString(data: urlData, encoding: NSUTF8StringEncoding);
//        
//        ipaddress = ip as! String;
//        
//        print("IP: " + ipaddress);
        
        return ipaddress;
        
        

    }
    
    func setIP()
    {
        
        if(ipaddress == "")
        {
            ipaddress = "-1";
        }
        
        let session = NSURLSession.sharedSession()
        
        
        let urlText = "http://ip.42.pl/raw";
        
        //these url and request objects are required for the connection method I use
        let myUrl = NSURL(string: urlText);
        let request = NSMutableURLRequest(URL:myUrl!);
        
        //set the httpmethod, and set a header value
        request.HTTPMethod = "GET";
        
        //objects for response and response error
        var reponseError: NSError?
        var response: NSURLResponse?
        
        
        print("getting ip...");
        //start task definition
        let task = session.dataTaskWithRequest(request, completionHandler:{
            urlData, response, error -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                print(urlData);
                print(response);
                
                do
                {
                    let ip = NSString(data: urlData!, encoding: NSUTF8StringEncoding);
                    self.ipaddress = ip as! String;
                }
                catch
                {
                    print("IP set failed");
                    return;
                }
                
                print("IP fetch: " + self.ipaddress);
                
                
            }//end of dispatch
            
        })//end of task
        task.resume();
        

    }
    
    func getPins()
    {
        var urlText = devProxy + "/*";
        
        let myUrl = NSURL(string: urlText);
        let request = NSMutableURLRequest(URL:myUrl!);
        
        //let loginString = NSString(format: "%@:%@", "webiopi", "raspberry");
        //let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!;
        //base64LoginString = loginData.base64EncodedStringWithOptions(nil);
        
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        
        //set some headers
        request.HTTPMethod = "GET";
        
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        
        //var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError);
        
        
        //start task
        let task = session.dataTaskWithRequest(request, completionHandler:{
            urlData, response, error -> Void in
            
            dispatch_async(dispatch_get_main_queue())
                {//start dispatch
                    

                    
                    if(urlData == nil)
                    {
                        print("nil on fetch from Pi");
                        return;
                    }
                    
                    print("successful fetch from Pi");
                    
                    let res = response as! NSHTTPURLResponse!;
                    var error: NSError?
                    
                    
                    //jsonData is where the data for the response is kept
                    
                   
                    
                    let jsonData:NSDictionary = try! NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    
                    
                    
                    let GPIOdata = jsonData.valueForKey("GPIO") as! NSDictionary;
                    //print(GPIOdata);
                    
                    for index in 0 ... 27
                    {
                        //print("setting pin ", terminator: "");
                        //print(index);

                        self.tabBarPins[index].setFromData(GPIOdata.valueForKey(String(index)) as! NSDictionary);
                        
                        //set the name to the pin number
                        if(self.tabBarPins[index].name == "label")
                        {
                            self.tabBarPins[index].setName(String(index));
                        }
                        
                        
                        self.tabBarPins[index].isGPIO = true;
                        
                        //Determines by the index if it's actually a GPIO number
                        if(index < 2 || index == 14 || index == 15 || index > 27)
                        {
                            self.tabBarPins[index].isGPIO = false;
                            self.tabBarPins[index].type = 0;
                        }
                        
                        //self.printPinList();
                        
                        //print(self.tabBarPins[index].on);
                        //println(self.tabBarPins[index].type);
                        //self.testValue = self.testValue - 1;
                        //println(self.testValue);
                        
                    }
                    
                    //println(self.testValue);
                    
                    //self.printPinList();
                    
                    var optionView = self.childViewControllers[1] as! OptionTableViewController;
                    
                    optionView.pins = self.tabBarPins;
                    optionView.tableView.reloadData();
                    optionView.syncWithTable();
                    
                    //sleep(10000);
                    //self.getPins();
                    
                    
            }//end dispatch
            
            
            
        })//end task
        
        task.resume();
        
        
        
    }
    
    func sendRequest(urlText: String, httpType: String)
    {
        let myUrl = NSURL(string: urlText);
        let request = NSMutableURLRequest(URL:myUrl!);

        
        //set some headers
        request.HTTPMethod = httpType;
        
        
        let reponseError: NSError?
        let response: NSURLResponse?
        
        
        //start task
        let task = session.dataTaskWithRequest(request, completionHandler:{
            urlData, response, error -> Void in
            
        })//end task
        
        task.resume();
        
        
    }
    
    func setFunction(sender: UIButton, newFunction: Bool)
    {
        let pinNumber = sender.tag;
        
        
        var nS = "in";
        
        if(newFunction)
        {
            nS = "out";
        }
        
        
        var urlText = devProxy + "/GPIO/";
        
        urlText += String(pinNumber) + "/function/" + nS;
        
        let myUrl = NSURL(string: urlText);
        let request = NSMutableURLRequest(URL:myUrl!);
        
        //let loginString = NSString(format: "%@:%@", "webiopi", "raspberry");
        //let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!;
        //base64LoginString = loginData.base64EncodedStringWithOptions(nil);
        
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        
        //set some headers
        request.HTTPMethod = "POST";
        
        
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        
        //var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError);
        
        var ps = "Posting " + nS + " to Pin " + String(pinNumber) + "function...";
        print(ps);
        
        
        
        //start task
        let task = session.dataTaskWithRequest(request, completionHandler:{
            urlData, response, error -> Void in
            
            dispatch_async(dispatch_get_main_queue())
            {//start dispatch
                
                var optionView = self.childViewControllers[1] as! OptionTableViewController;
                
                var pinView = self.childViewControllers[0] as! PinTableViewController;
                
                var cell = optionView.getCellAtIndex(pinNumber);
                
                let res = response as! NSHTTPURLResponse!;
                var error: NSError?
                
                
                
                if(res == nil)
                {
                    print("nil on function post from Pi");

                }
                else
                {
                    //jsonData is where the data for the response is kept
                    do
                    {
                        let jsonData:NSData = try NSJSONSerialization.JSONObjectWithData(urlData!, options:[]) as! NSData
                        
                        print("jsonData:");
                        print(jsonData);
                        
                    }
                    catch
                    {
                        print("jsonData not successful for pin function set");
                    }
                    
                    
                    //Successful post!
                    if(res.statusCode == 200)
                    {
                        
                        //set the pin function
                        optionView.pins[pinNumber].changeFunction(newFunction);
                        
                        
                        sender.setTitle(cell.getType(optionView.pins[pinNumber].type), forState: UIControlState.Normal);
                        

                        optionView.syncWithTable();
                        
                        

                    }
                    else
                    {
                        print("Response status fail: " + String(res.statusCode));
                        //cell.onState.on = !cell.onState.on;
                    }
                    
                }
                
                
                
                
                
                print();
                print("urlData:");
                print(urlData);
                print();
                
                print("res:");
                print(res);
                
                //Status code: 200 is inside 'res' somewhere, THAT is what will tell me if we were successful
                
                
                sender.enabled = true;
                
            }//end dispatch
            
            self.getPins();
            
        })//end task
        
        task.resume();
        
        
    }
    
    func setPin(pinNumber: Int, newState: Bool)
    {
        var nS = "0";
        
        if(newState)
        {
            nS = "1";
        }
        
        
        var urlText = devProxy + "/GPIO/";
        
        urlText += String(pinNumber) + "/value/" + nS;
        
        let myUrl = NSURL(string: urlText);
        let request = NSMutableURLRequest(URL:myUrl!);
        
        //let loginString = NSString(format: "%@:%@", "webiopi", "raspberry");
        //let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!;
        //base64LoginString = loginData.base64EncodedStringWithOptions(nil);
        
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        
        //set some headers
        request.HTTPMethod = "POST";
        
        
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        
        //var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError);
        
        var ps = "Posting " + nS + " to Pin " + String(pinNumber) + "...";
        print(ps);
        
        
        
        //start task
        let task = session.dataTaskWithRequest(request, completionHandler:{
            urlData, response, error -> Void in
            
            dispatch_async(dispatch_get_main_queue())
                {//start dispatch
                    
                    var optionView = self.childViewControllers[1] as! OptionTableViewController;
                    
                    var pinView = self.childViewControllers[0] as! PinTableViewController;
                    
                    var cell = pinView.getCellForPinNumber(pinNumber);

                    let res = response as! NSHTTPURLResponse!;
                    var error: NSError?
                    
                    if(res == nil)
                    {
                        print("nil on post from Pi");
                        cell.onState.on = !cell.onState.on;
                    }
                    else
                    {
                        //jsonData is where the data for the response is kept
                        do
                        {
                            let jsonData:NSData = try NSJSONSerialization.JSONObjectWithData(urlData!, options:[]) as! NSData
                            
                            print("jsonData");
                            print(jsonData);
                            
                        }
                        catch
                        {
                            print("jsonData not successful for pin set");
                        }
                        
                        
                        //Successful post!
                        if(res.statusCode == 200)
                        {
                            self.setPinValue(pinNumber, value: newState);
                        }
                        else
                        {
                            print("Response status fail: " + String(res.statusCode));
                            cell.onState.on = !cell.onState.on;
                        }

                    }

                    
                    
                    
                    
                    print();
                    print("urlData:");
                    print(urlData);
                    print();
                    
                    print("res:");
                    print(res);
                    
                    //Status code: 200 is inside 'res' somewhere, THAT is what will tell me if we were successful
                    
                    
                    cell.onState.enabled = true;
                    cell.spinner.stopAnimating();
                    
                    
                    
            }//end dispatch
            
            self.getPins();
            
        })//end task
        
        task.resume();
    
    }

    
    func printPinList()
    {
        
        
        for p in tabBarPins{
            print(p.name, terminator: "");
            print(" ", terminator: "");
            print(p.stateName, terminator: "");
            print(" ", terminator: "");
            print(p.type, terminator: "");
            
            print("");
            
        }
        
        
        print("");
        
    }
    
    
    //sets one pin to HIGH or LOW (not on the pi, just in this program)
    func setPinValue(pinNumber: Int, value: Bool)
    {
        tabBarPins[pinNumber].on = value;
        var optionView = self.childViewControllers[1] as! OptionTableViewController;
        var pinView = self.childViewControllers[0] as! PinTableViewController;
        
        optionView.pins[pinNumber].on = value;
        pinView.pins[pinNumber].on = value;
        
        optionView.tableView.reloadData();
        pinView.tableView.reloadData();

        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
