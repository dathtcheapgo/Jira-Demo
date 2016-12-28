//
//  Session.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/14/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class Session {
    private static var store: Session?
    static var shareInstance: Session {
        if store == nil { store = Session() }
        return store!
    }
    
    private var userDefault = UserDefaults.standard
    
    var firebaseToken: String? {
        set { userDefault.set(newValue, forKey: "firebaseToken") }
        get { return userDefault.value(forKey: "firebaseToken") as? String }
    }
    
    var activeInfo: CGActive? {
        set { userDefault.set(newValue?.toJSON(), forKey: "activeInfo") }
        get {
            let json = userDefault.value(forKey: "activeInfo")
            var objectData = CGActive()
            objectData = Mapper<CGActive>().map(JSONObject: json, toObject: objectData)
            return objectData
        }
    }
}
