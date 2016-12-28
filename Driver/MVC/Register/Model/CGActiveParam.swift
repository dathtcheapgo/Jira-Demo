//
//  CGActiveParam.swift
//
//  Created by Đinh Anh Huy on 10/31/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class CGActiveParam: Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kCGRegisterParamTypeKey: String = "type"
	internal let kCGRegisterParamActivationKey: String = "activation"
	internal let kCGRegisterParamMobileKey: String = "mobile"
	internal let kCGRegisterParamCountryCodeKey: String = "country_code"


    // MARK: Properties
	public var type: String?
	public var activation: CGActivation?
	public var mobile: String?
	public var countryCode: String?

    // MARK: ObjectMapper Initalizers
    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    
    init() { }
    
    public required init?(map: Map){
        activation = CGActivation()
    }

    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    public func mapping(map: Map) {
		type <- map[kCGRegisterParamTypeKey]
		activation <- map[kCGRegisterParamActivationKey]
		mobile <- map[kCGRegisterParamMobileKey]
		countryCode <- map[kCGRegisterParamCountryCodeKey]

    }
}

extension CGActiveParam {
    public class CGActivation: Mappable {
        
        // MARK: Declaration for string constants to be used to decode and also serialize.
        internal let kCGActivationCodeKey: String = "code"
        
        
        // MARK: Properties
        public var code: Int?
        
        init() {
            
        }
        
        // MARK: ObjectMapper Initalizers
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
            code <- map[kCGActivationCodeKey]
        }
    }
}
