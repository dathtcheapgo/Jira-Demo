//
//  CGBaseResult.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/14/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class CGBaseResult: Mappable {
    var status: Int?
    var error: String?
    var success: Int?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        error   <- map["error"]
        status   <- map["status"]
    }
}
