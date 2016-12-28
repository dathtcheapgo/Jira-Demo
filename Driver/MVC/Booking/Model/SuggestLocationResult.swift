//
//  SuggestLocation.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/13/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper

class SuggestLocationResult: Mappable {
    var predictions: [Prediction]?
    var status = ""
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        predictions <- map["predictions"]
        status      <- map["status"]
    }
    
    class Prediction: Mappable {
        var description = ""
        var id = ""
            
        required init?(map: Map) {
            
        }
        
        func mapping(map: Map) {
            description <- map["description"]
            id          <- map["id"]
        }
    }
}
