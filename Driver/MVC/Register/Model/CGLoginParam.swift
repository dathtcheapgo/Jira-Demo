//
//  CGLoginParam.swift
//
//  Created by Đinh Anh Huy on 10/31/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class CGLoginParam: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kCGLoginParamTypeKey: String = "type"
	internal let kCGLoginParamCountryCodeKey: String = "country_code"
	internal let kCGLoginParamMobileKey: String = "mobile"

    // MARK: Properties
	public var type: String?
	public var countryCode: String?
	public var mobile: String?

    // MARK: ObjectMapper Initalizers
    init() {
        
    }
    
    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    public required init?(map: Map){

    }

    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    public func mapping(map: Map) {
		type <- map[kCGLoginParamTypeKey]
		countryCode <- map[kCGLoginParamCountryCodeKey]
		mobile <- map[kCGLoginParamMobileKey]

    }
}
