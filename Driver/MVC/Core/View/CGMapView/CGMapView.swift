
//
//  CGMapView.swift
//  CGMapView
//
//  Created by Đinh Anh Huy on 10/25/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import GoogleMaps

enum CGMapViewType {
    case passenger
    case delivery
    case tour
    case carHire
}

class CGMapView: GMSMapView {
    var startMarker = CGMarker()
    var endMarker = CGMarker()
    var drivers = [CGMarker]()
    var riders = [CGMarker]()
    var directionLine: GMSPolyline!
    //default type CMMapView
    var type: CGMapViewType = .passenger
    
    //MARK: init control
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initControl()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initControl()
    }
    
    func initControl() {
        startMarker.map = self
        endMarker.map = self
    }
    
    //MARK: function
    public func zoomCamera(locationsToDisplay: [CLLocationCoordinate2D],
                           marginRation: CLLocationDegrees = 0.1,
                           animationDuration: TimeInterval = 0) {
        
        //find northest, southwest point
        var northeast = CLLocationCoordinate2D()
        var southwest = CLLocationCoordinate2D()
        northeast.latitude = Double.min
        northeast.longitude = Double.min
        southwest.latitude = Double.max
        southwest.longitude = Double.max
        for location in locationsToDisplay {
            if northeast.latitude < location.latitude { northeast.latitude = location.latitude }
            if northeast.longitude < location.longitude { northeast.longitude = location.longitude }
            
            if southwest.latitude > location.latitude { southwest.latitude = location.latitude }
            if southwest.longitude > location.longitude { southwest.longitude = location.longitude }
        }
        
        //caculate margin space
        var marginSpace: CLLocationDegrees = 0
        let deltaX = abs(northeast.latitude - southwest.latitude)
        let deltaY = abs(northeast.longitude - southwest.longitude)
        if deltaX > deltaY { marginSpace = deltaX * marginRation }
        else { marginSpace = deltaY * marginRation }
        
        //extend map view zoom size
        northeast.latitude += marginSpace
        northeast.longitude += marginSpace
        southwest.latitude -= marginSpace
        southwest.longitude -= marginSpace
        
        //change camera to view contain list location after add margin space
        let bounds = GMSCoordinateBounds(coordinate: northeast, coordinate: southwest)
        let camera = self.camera(for: bounds, insets: UIEdgeInsets())
        if animationDuration == 0 { self.camera = camera! }
        else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(animationDuration)
            self.camera = camera!
            CATransaction.commit()
        }
        
    }
    
    public func moveCamera(location: CGLocation, duration: TimeInterval = 0) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        self.animate(to: GMSCameraPosition.camera(withLatitude: location.lat,
                                                  longitude: location.long,
                                                  zoom: camera.zoom))
        CATransaction.commit()
    }
    
    public func updateDriversLocation(infos: [(id: String, location: CGLocation)]) {
        var currentInfo: (id: String, location: CGLocation)!
        for i in 0...infos.count - 1 {
            currentInfo = infos[i]
            for driver in drivers {
                if driver.id == currentInfo.id {
                    driver.updateLocation(location: currentInfo.location,
                                          updateRotation: true, useAnimation: true)
                }
            }
        }
    }
    
    public func updateRidersLocation(infos: [(id: String, location: CGLocation)]) {
        var currentInfo: (id: String, location: CGLocation)!
        for i in 0...infos.count - 1 {
            currentInfo = infos[i]
            for rider in riders {
                if rider.id == currentInfo.id {
                    rider.updateLocation(location: currentInfo.location,
                                          updateRotation: true, useAnimation: true)
                }
            }
        }
    }
    
    public func drawRoute(gmsPath: GMSPath,
                   northeast: CLLocationCoordinate2D,
                   southwest: CLLocationCoordinate2D) {
        if directionLine != nil { directionLine.map = nil } //remove it from map
        
        directionLine = GMSPolyline(path: gmsPath)
        directionLine!.strokeWidth = 7
        directionLine!.strokeColor = UIColor.green
        directionLine!.map = self
    }
    
    public func updateStartMarkerLocation(location: CGLocation,
                                          animationDuration: TimeInterval = 0) {
        
        startMarker.updateLocation(location: location)
    }
    
    public func updateEndMarkerLocation(location: CGLocation,
                                        animationDuration: TimeInterval = 0) {
        
        endMarker.updateLocation(location: location)
    }
}

extension Double {
    static var min = DBL_MIN
    static var max = DBL_MAX
}
