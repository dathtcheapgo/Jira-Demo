//
//  GoogleMapApi.swift
//  drivers
//
//  Created by Đinh Anh Huy on 10/10/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import GoogleMaps

class GoogleMapApi: BaseAPI {
    
    let host = "https://maps.googleapis.com/"
    var type = APIType.None
    var viewCallApi: UIView? = nil
    
    enum APIType: String {
        case None               = ""
        case GetDirection       = "maps/api/directions/json"
        case SuggestLocation    = "maps/api/place/autocomplete/json"
    }
    
    func getApiURL(type: APIType) -> String {
        return "\(host)\(type.rawValue)"
    }
    
    func getSuggestLocation(location: String, language: String = "vi", completeBlock: @escaping CompletionBlock) -> APITask {
        type = APIType.SuggestLocation
        let url = getApiURL(type: type)
        
        var param = [String: String]()
        param["types"]          = "geocode"
        param["key"]            = Config.shareInstance.googleMapAPIKey
        param["language"]       = language
        param["input"]          = location
        
        print(param)
        do {
            try Alamofire.request(url.asURL(), method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    let objectData = SuggestLocationResult()
                    _ = Mapper<SuggestLocationResult>().map(JSONObject: JSON, toObject: objectData)
                    self.task.result = objectData
                    _ = completeBlock(self.task)
                }
            })
        } catch {
            fatalError("Wrong url")
        }
        return task
    }
    
    func getRoute(originAddress: String, destinationAddress: String, completeBlock: @escaping CompletionBlock) -> APITask {
        
        type = APIType.GetDirection
        let url = getApiURL(type: type)
        
        var param = [String: String]()
        param["key"]            = Config.shareInstance.googleMapAPIKey
        param["origin"]         = originAddress
        param["destination"]    = destinationAddress
        
        print(param)
        
        do {
            try Alamofire.request(url.asURL(), method: HTTPMethod.get, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { response in
                
                print(response.request)  // original URL request
                print(response.response) // HTTP URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    let objectData = GetDirectionResult()
                    _ = Mapper<GetDirectionResult>().map(JSONObject: JSON, toObject: objectData)
                    
                    self.task.result = objectData
                    _ = completeBlock(self.task)
                }
            })
        } catch {
            fatalError("Wrong url")
        }
        return task
    }
}

extension CLLocationCoordinate2D {
    func gmsString() -> String {
        return "\(self.latitude), \(self.longitude)"
    }
}

