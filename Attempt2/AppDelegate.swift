//
//  AppDelegate.swift
//  Attempt2
//
//  Created by Hunter Heard on 3/31/16.
//  Copyright (c) 2016 Hunter Heard. All rights reserved.
//




//to do list

//Register for notifications
//work out how to get weaved, webiopi, or the Raspberry Pi to send notifications

//get asynchronous requests working
//get the Activity Indicator working with those


//Top
//Figure out sending/receiving webiopi requests
//Figure out how to tie those to the switches
//figure out where to put the requests

//figure out how to save app settings
//Figure out how to create a structure of app settings
//Figure out how to save it, or send it to the raspberry pi
//Figure out how to retrieve those settings, or load them



import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var pins = [Pin]();

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

