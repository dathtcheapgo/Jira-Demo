//
//  CGMarker.swift
//  CGMapView
//
//  Created by Đinh Anh Huy on 10/25/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import GoogleMaps

public class CGMarker: GMSMarker {
    static var rotateTime: TimeInterval = 0.5/90 //rotate 90 degree in 0.5s
    var locationInfos = [CGLocation]()
    public var startTransform: CATransform3D!
    var id: String?
    
    override init() {
        super.init()
        
        
    }
    
    convenience init(map: CGMapView, image: UIImage) {
        self.init()
        
        self.map = map
        icon = image
    }
    
    public func updateLocation(location: CGLocation, updateRotation: Bool = false, useAnimation: Bool = true) {
        if locationInfos.count == 0 {
            locationInfos.append(location)
            locationInfos.append(location)
            startTransform = layer.transform
        } else {
            locationInfos[0] = locationInfos[1]
            locationInfos[1] = location
        }
        let moveDuration = locationInfos.last!.timeStamp - locationInfos.first!.timeStamp
        
        if useAnimation {
            CATransaction.begin()
            CATransaction.setAnimationDuration(moveDuration)
            position = location.clLocation
            CATransaction.commit()
        } else { position = location.clLocation }
        if updateRotation { self.updateRotation() }
    }
    
    public func updateRotation() {
        
        let lastLocation = locationInfos.last!
        let firstLocation = locationInfos.first!
        
        if firstLocation == lastLocation { return }
        
        let deltaX = lastLocation.long - firstLocation.long
        let deltaY = lastLocation.lat - firstLocation.lat
        let v1 = CGVector(dx: 0, dy: 1)
        let v2 = CGVector(dx: deltaX, dy: deltaY)
        let angle = (atan2(v1.dy, v1.dx) - atan2(v2.dy, v2.dx)).radiansToDegrees
        let rotateDuration = CGMarker.rotateTime * 90
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(rotateDuration)
        rotation = CLLocationDegrees(angle)
        CATransaction.commit()
    }
}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
