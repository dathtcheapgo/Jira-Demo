//
//  CGRequestParam.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/14/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper
//
//class CGLocation: Mappable {
//    var long: Double?
//    var lat: Double?
//    
//    init() {
//        
//    }
//    
//    required init?(map: Map) {
//        
//    }
//    
//    func mapping(map: Map) {
//        long <- map["long"]
//        lat <- map["lat"]
//    }
//}

class CGRequestParam: Mappable {
    var id: String?
    var pickupLocation: CGLocation?
    var destination: CGLocation?
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id              <- map["id"]
        pickupLocation  <- map["pickupLocation"]
        destination     <- map["destination"]
    }
}
