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
        
        
        println("loading Tab Bar Controller\n");
        
        
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
        
        var url = NSURL(string: "http://ip.42.pl/raw");
        
        let request = NSMutableURLRequest(URL:url!);
        request.HTTPMethod = "GET";
        var response: NSURLResponse?
        var reponseError: NSError?

        
        var urlData: NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)!;

        var ip = NSString(data: urlData, encoding: NSUTF8StringEncoding);
        
        ipaddress = ip as String;
        
        println(ipaddress);
        
        return ipaddress;
        
        

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
                        println("nil on fetch from Pi");
                        return;
                    }
                    
                    println("successful fetch from Pi");
                    
                    let res = response as NSHTTPURLResponse!;
                    var error: NSError?
                    
                    
                    //jsonData is where the data for the response is kept
                    let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                    
                    let GPIOdata = jsonData.valueForKey("GPIO") as NSDictionary;
                    println(GPIOdata);
                    
                    for index in 0 ... 15
                    {
                        print("setting pin ");
                        println(index);

                        self.tabBarPins[index].setFromData(GPIOdata.valueForKey(String(index)) as NSDictionary);
                        
                        //self.printPinList();
                        
                        //print(self.tabBarPins[index].on);
                        //println(self.tabBarPins[index].type);
                        //self.testValue = self.testValue - 1;
                        //println(self.testValue);
                        
                    }
                    
                    //println(self.testValue);
                    
                    //self.printPinList();
                    
                    var optionView = self.childViewControllers[1] as OptionTableViewController;
                    
                    optionView.pins = self.tabBarPins;
                    optionView.tableView.reloadData();
                    optionView.syncWithTable();
                    
                    
            }//end dispatch
            
            
            
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
        
        
        //start task
        let task = session.dataTaskWithRequest(request, completionHandler:{
            urlData, response, error -> Void in
            
            dispatch_async(dispatch_get_main_queue())
                {//start dispatch
                    
                    
                    
                    if(urlData == nil)
                    {
                        println("nil on post from Pi");
                        return;
                    }
                    
                    println("successful post from Pi");
                    
                    let res = response as NSHTTPURLResponse!;
                    var error: NSError?
                    
                    
                    //jsonData is where the data for the response is kept
                    //let jsonData:NSDictionary = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers , error: &error) as NSDictionary
                    
                    println(urlData);
                    
                    
                    var optionView = self.childViewControllers[1] as OptionTableViewController;
                    
                    var pinView = self.childViewControllers[0] as PinTableViewController;
                    
                    self.setPinValue(pinNumber, value: newState);
                    
                    var cell = pinView.getCellForPinNumber(pinNumber);
                    
                    
                    cell.onState.enabled = true;
                    
                    
                    
            }//end dispatch
            
            
            
        })//end task
        
        task.resume();
    
    }

    
    func printPinList()
    {
        
        
        for p in tabBarPins{
            print(p.name);
            print(" ");
            print(p.stateName);
            print(" ");
            print(p.type);
            
            println();
            
        }
        
        
        println();
        
    }
    
    
    //sets one pin to HIGH or LOW (not on the pi, just in this program)
    func setPinValue(pinNumber: Int, value: Bool)
    {
        tabBarPins[pinNumber].on = value;
        var optionView = self.childViewControllers[1] as OptionTableViewController;
        var pinView = self.childViewControllers[0] as PinTableViewController;
        
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
