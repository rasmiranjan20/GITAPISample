//
//  WebserviceConfigure.swift
//  GITAPISample
//
//  Created by Rasmiranjan Sahu on 10/24/22.
//

import Foundation

protocol WebserviceConfigureble {
    var url             : URL {get}
    var requestTypes    : HTTPTypes {get}
    var parameters      : [String : String]? {get}
    var headers         : [String : String]? {get}
    var request         : URLRequest? {get}
}

struct WebserviceConfigure : WebserviceConfigureble {
    var url         : URL
    var requestTypes: HTTPTypes
    var parameters  : [String : String]?
    var headers     : [String : String]?
    var timeOut     : Double
    
    init(url: URL, requestTypes: HTTPTypes, parameters: [String : String]? = nil,
         headers: [String : String]? = nil, timeOut: Double = 30) {
        self.url = url
        self.requestTypes = requestTypes
        self.parameters = parameters
        self.headers = headers
        self.timeOut = timeOut
    }
    
    var request : URLRequest? {
        var req = URLRequest(url: url)
        req.httpMethod = requestTypes.rawValue
        if let parameters, let param = try? JSONEncoder().encode(parameters) {
            req.httpBody = param
        }
        req.allHTTPHeaderFields = headers
        req.timeoutInterval     = timeOut
       return req
    }
}
