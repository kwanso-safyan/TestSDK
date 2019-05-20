//
//  Configuration.swift
//  Alamofire
//
//  Created by kwanso-ios on 5/20/19.
//

import Foundation

class Configuration: NSObject {
    var ssoBaseUrl: String = ""
    var iOSClientId:String = ""
    var iOSClientSecret: String = ""
    var iOSCodeVerifier: String = ""
    
    
    //:- For configurations
    init(ssoBaseUrl: String, iOSClientId: String, iOSClientSecret: String, iOSCodeVerifier: String) {
        
        self.ssoBaseUrl = ssoBaseUrl
        self.iOSClientId = iOSClientId
        self.iOSClientSecret = iOSClientSecret
        self.iOSCodeVerifier = iOSCodeVerifier
    }
    
}
