//
//  CGActive.swift
//
//  Created by Đinh Anh Huy on 10/31/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class CGActive: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kCGLoginInfoDataKey: String = "data"
    internal let kCGLoginInfoStatusKey: String = "status"
    internal let kCGActiveErrorKey: String = "error"
    
    // MARK: Properties
    public var data: CGData?
    public var status: Int?
    public var error: CGError?
    
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
        data <- map[kCGLoginInfoDataKey]
        status <- map[kCGLoginInfoStatusKey]
        error <- map[kCGActiveErrorKey]
    }
}

extension CGActive {
    public class CGData: Mappable {
        
        // MARK: Declaration for string constants to be used to decode and also serialize.
        internal let kCGDataLastNameKey: String = "last_name"
        internal let kCGDataGoogleIdKey: String = "google_id"
        internal let kCGDataAvatarKey: String = "avatar"
        internal let kCGDataEmailKey: String = "email"
        internal let kCGDataTypeKey: String = "type"
        internal let kCGDataUsernameKey: String = "username"
        internal let kCGDataFirstNameKey: String = "first_name"
        internal let kCGDataFacebookIdKey: String = "facebook_id"
        internal let kCGDataInternalIdentifierKey: String = "_id"
        internal let kCGDataTokenKey: String = "token"
        internal let kCGDataGenderKey: String = "gender"
        internal let kCGDataVKey: String = "__v"
        internal let kCGDataCreatedKey: String = "created"
        internal let kCGDataMobileKey: String = "mobile"
        internal let kCGDataCountryCodeKey: String = "country_code"
        
        
        // MARK: Properties
        public var lastName: String?
        public var googleId: String?
        public var avatar: String?
        public var email: String?
        public var type: String?
        public var username: String?
        public var firstName: String?
        public var facebookId: String?
        public var internalIdentifier: String?
        public var token: CGToken?
        public var gender: Int?
        public var v: Int?
        public var created: String?
        public var mobile: String?
        public var countryCode: String?
        
        
        
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
            lastName <- map[kCGDataLastNameKey]
            googleId <- map[kCGDataGoogleIdKey]
            avatar <- map[kCGDataAvatarKey]
            email <- map[kCGDataEmailKey]
            type <- map[kCGDataTypeKey]
            username <- map[kCGDataUsernameKey]
            firstName <- map[kCGDataFirstNameKey]
            facebookId <- map[kCGDataFacebookIdKey]
            internalIdentifier <- map[kCGDataInternalIdentifierKey]
            token <- map[kCGDataTokenKey]
            gender <- map[kCGDataGenderKey]
            v <- map[kCGDataVKey]
            created <- map[kCGDataCreatedKey]
            mobile <- map[kCGDataMobileKey]
            countryCode <- map[kCGDataCountryCodeKey]
            
        }
    }
}

extension CGActive.CGData {
    public class CGToken: Mappable {
        
        // MARK: Declaration for string constants to be used to decode and also serialize.
        internal let kCGTokenRefeshTokenKey: String = "refesh_token"
        internal let kCGTokenTokenKey: String = "token"
        internal let kCGTokenExpiredAtKey: String = "expired_at"
        
        
        // MARK: Properties
        public var refeshToken: String?
        public var token: String?
        public var expiredAt: Int?
        
        
        
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
            refeshToken <- map[kCGTokenRefeshTokenKey]
            token <- map[kCGTokenTokenKey]
            expiredAt <- map[kCGTokenExpiredAtKey]
        }
    }
}

extension CGActive {
    public class CGError: Mappable {
        
        // MARK: Declaration for string constants to be used to decode and also serialize.
        internal let kCGErrorTitleKey: String = "title"
        internal let kCGErrorMessageKey: String = "message"
        internal let kCGErrorCodeKey: String = "code"
        
        // MARK: Properties
        public var title: String?
        public var message: String?
        public var code: Int?
        
        
        init() {
            
        }
        // MARK: ObjectMapper Initalizers
        /**
         Map a JSON object to this class using ObjectMapper
         - parameter map: A mapping from ObjectMapper
         */
        required public init?(map: Map){
            
        }
        
        /**
         Map a JSON object to this class using ObjectMapper
         - parameter map: A mapping from ObjectMapper
         */
        public func mapping(map: Map) {
            title <- map[kCGErrorTitleKey]
            message <- map[kCGErrorMessageKey]
            code <- map[kCGErrorCodeKey]
            
        }
    }

}
