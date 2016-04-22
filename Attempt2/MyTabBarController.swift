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
    
    var ipaddress = "";
    
    var weavedToken = "";
    
    var webioPiLogged = false;
    
    var raspberryDevice = NSObject();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getIP();

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
