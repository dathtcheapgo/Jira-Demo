//
//  Config.swift
//  drivers
//
//  Created by Đinh Anh Huy on 10/11/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit

class Config {
    private static var store: Config?
    static var shareInstance: Config {
        get {
            if Config.store == nil { Config.store = Config() }
            return Config.store!
        }
    }
    
    private var plistValue: NSDictionary {
        get {
            var myDict: NSDictionary!
            if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
                myDict = NSDictionary(contentsOfFile: path)!
            }
            return myDict
        }
    }
    
    private var googleMapValue: NSDictionary {
        get {
            return plistValue["GoogleMap"] as! NSDictionary
        }
    }
    
    private var userInterface: NSDictionary {
        get {
            return plistValue["UserInterface"] as! NSDictionary
        }
    }
    
    var googleMapBundleId: String {
        get {
            return googleMapValue["GoolgeMap-BundleId"] as! String
        }
    }
    
    var googleMapKey: String {
        get {
            return googleMapValue["GoolgeMap-Key"] as! String
        }
    }
    
    var googleMapAPIKey: String {
        get {
            return googleMapValue["GoogleMapAPI-Key"] as! String
        }
    }
    
    var socketURL: String {
        return plistValue["SocketURL"] as! String
    }
    
    var apiURL: String {
        return plistValue["ApiURL"] as! String
    }
    
    var animateDuration: TimeInterval {
        return userInterface["animateDuration"] as! TimeInterval
    }
}
