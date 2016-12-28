//
//  CGAPI.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/14/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class CGAPI: BaseAPI {
    let host = Config.shareInstance.apiURL
    var type = APIType.None
    var viewCallApi: UIView? = nil
    
    enum APIType: String {
        case None               = ""
        //register
        case login      = "api/user/login"
        case active     = "api/user/activate"
        //booking
        case requestPickup      = "api/transit/request"
        
    }
    
    func getApiURL(type: APIType) -> String {
        return "\(host)\(type.rawValue)"
    }

    func requestDriver(id: String, pickLocation: CLLocationCoordinate2D,
                       desLocation: CLLocationCoordinate2D,
                       completeBlock: @escaping CompletionBlock) -> APITask {
        type = APIType.requestPickup
        let url = getApiURL(type: type)
        
        let param = CGRequestParam()
        param.id = id
        param.pickupLocation = CGLocation()
        param.pickupLocation?.long = pickLocation.longitude
        param.pickupLocation?.lat = pickLocation.latitude
        param.destination = CGLocation()
        param.destination?.long = desLocation.longitude
        param.destination?.lat = desLocation.latitude
        
        print(param.toJSON())
        
        print(param)
        do {
            var request = try URLRequest(url: url.asURL())
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: param.toJSON())
            
            Alamofire.request(request)
                .responseJSON { response in
                    // do whatever you want here
                    switch response.result {
                    case .failure(let error):
                        print(error)
                        
                        if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                            print(responseString)
                            if let _ = response.result.value {
                                var objectData = CGBaseResult()
                                objectData = Mapper<CGBaseResult>().map(JSONObject: data, toObject: objectData)
                                self.task.result = objectData
                                _ = completeBlock(self.task)
                            }
                        }
                    case .success(let responseObject):
                        print(responseObject)
                    }
            }
        } catch {
            fatalError("Wrong url")
        }
        return task
    }
    
    //MARK: Login API
    // User login using mobile phone. If user does not exist, the system will create one
    func login(sender: CGLoginParam,
               completeBlock: @escaping CompletionBlock) -> APITask {
        type = APIType.login
        let url = getApiURL(type: type)
        let json = sender.toJSON()
        
        print(json)
        do {
            var request = try URLRequest(url: url.asURL())
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: json)
            
            Alamofire.request(request).responseObject(completionHandler: { (response: DataResponse<CGBaseResult>) in
                do {
                    guard let data = response.result.value else { throw APIError.conflictTypeResponse }
                    self.task.result = data
                    _ = completeBlock(self.task)
                } catch {
                    fatalError("Cant Parse data")
                }
            })
        } catch {
            fatalError("Wrong url")
        }
        return task
    }
    
    
    // Activate user using SMS code
    func active(sender: CGActiveParam,
               completeBlock: @escaping CompletionBlock) -> APITask {
        type = APIType.active
        let url = getApiURL(type: type)
        let json = sender.toJSON()
        
        print(json)
        do {
            var request = try URLRequest(url: url.asURL())
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: json)
            
            Alamofire.request(request).responseObject(completionHandler: { (response: DataResponse<CGActive>) in
                do {
                    guard let data = response.result.value else { throw APIError.conflictTypeResponse }
                    self.task.result = data
                    _ = completeBlock(self.task)
                } catch {
                    fatalError("Cant Parse data")
                }
            })
        } catch {
            fatalError("Wrong url")
        }
        return task
    }
}
