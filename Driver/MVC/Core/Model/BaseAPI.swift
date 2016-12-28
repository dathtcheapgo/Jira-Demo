//
//  BaseAPI.swift
//  rider
//
//  Created by Đinh Anh Huy on 10/11/16.
//  Copyright © 2016 Đinh Anh Huy. All rights reserved.
//

import UIKit
import ObjectMapper

enum APIError: Error {
    case conflictTypeResponse
    case dontHaveResponse
    case undefined
    case clientInputError
    case serverError
}

typealias CompletionBlock = (_ task: APITask) -> APITask
typealias ContinueBlock = (_ task: APITask, _ block: () -> Void) -> APITask

class APITask {
    var result: Mappable?
    var error: NSError?
    
    var continueWithBlock: ContinueBlock = { (task: APITask, block: () -> Void) -> APITask in
        block()
        return task
    }
}

protocol APIProtocol {
    func apiReceiveSuccess(sender: BaseAPI, data: Any)
    func apiReceiveFail()
    func apiReceiveError()
}

class BaseAPI {
    var delegate: APIProtocol?
    let task = APITask()
}
