//
//  CGLocation.swift
//  CGMapView
//
//  Created by Đinh Anh Huy on 10/25/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreLocation

public class CGLocation: Mappable {
    var lat: Double = 0
    var long: Double = 0
    var timeStamp: TimeInterval = 0 //time in second
    
    var clLocation: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: self.long)
    }
    
    init() {
        
    }
    
    init(location: CLLocationCoordinate2D) {
        lat = location.latitude
        long = location.longitude
    }
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        lat <- map["lat"]
        long <- map["long"]
    }
}

extension CGLocation {
    static func ==(left: CGLocation, right: CGLocation) -> Bool {
        return left.lat == right.lat && left.long == right.long
    }
}
