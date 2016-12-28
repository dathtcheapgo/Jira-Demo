//
//  SocketConnection.swift
//  drivers
//
//  Created by Đinh Anh Huy on 10/10/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import SocketIO

protocol SocketConnectionDelegate {
    func updateLocationSocket(long: Double, lat: Double, timestamp: Double)
}

class CGSocketConnection {
    private static var store: CGSocketConnection?
    static var shareInstance: CGSocketConnection {
        if store == nil { store = CGSocketConnection() }
        return store!
    }
    
    var delegate: SocketConnectionDelegate?
    let socket = SocketIOClient(socketURL: URL(string: Config.shareInstance.socketURL)!, config: [.log(true), .forcePolling(true)])
    
    func connectAndRegister() {
        socket.connect()
        socket.on("connect") { (_, _) in
            let dict = NSMutableDictionary()
            dict["type"] = "rider"
            dict["id"] = Session.shareInstance.firebaseToken
            self.socket.emit("register", dict.jsonString())
            
            self.socket.on("location") { (data, ack) in
                let dict = self.convertStringToDictionary(json: (data.last as! String))!
                let locationDict = dict["location"] as! NSDictionary
                let long = locationDict["long"] as! Double
                let lat = locationDict["lat"] as! Double
                let timestamp = dict["timestamp"] as! Double
                
                let delay = Date().timeIntervalSince1970 - timestamp
                print("DELAY-TIME: index[\(index)] \(delay)")
                if delay > 1 {
                    print("TOO MUCH DELAY")
                }
                
                self.delegate?.updateLocationSocket(long: long, lat: lat, timestamp: timestamp)
            }
        }
    }
    
    //register-{ }
    
    func updateLocation(latitude: Double, longitude: Double) {
        let dict = NSMutableDictionary()

        dict["latitude"] = latitude
        dict["longitude"] = longitude
        dict["timestamp"] = NSDate().timeIntervalSince1970
        
        self.socket.emit("location", dict.jsonString())
    }
    
    func convertStringToDictionary(json: String) -> [String: AnyObject]? {
        if let data = json.data(using: String.Encoding.utf8) {
            let json: [String: AnyObject]
            try! json = (JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject])!
            return json
        }
        return nil
    }
}

extension NSMutableDictionary {
    func jsonString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            let str = String(data: jsonData, encoding: String.Encoding.utf8)!
            return str
        } catch let error as NSError {
            print(error)
        }
        return ""
    }
}
