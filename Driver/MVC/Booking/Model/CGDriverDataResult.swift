//
//  CGDriverDataResult.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/14/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper

class CGDriverDataResult: Mappable {
    
    var id: String?
    var location: CGLocation?
    var collapseKey: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id          <- map["id"]
        location    <- map["location"]
        collapseKey <- map["collapseKey"]
    }
}
