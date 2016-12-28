//
//  CGNotificationRequestResult.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/14/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class CGNotificationBaseResult: Mappable {
    var success: String?
    var error: String?
    var collapseKey: String?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success     <- map["success"]
        error       <- map["error"]
        collapseKey <- map["collapse_key"]
    }
}
