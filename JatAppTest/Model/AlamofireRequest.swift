//
//  AlamofireRequest.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequest {

    let parameters : [String : String]
    let method : HTTPMethod
    let url : String
    let headers : HTTPHeaders

    init(params : [String : String]? = nil, requestedMethod : HTTPMethod, requestedUrlType : String, headers: HTTPHeaders? = nil){
        if let isparams = params {
            self.parameters = isparams
        } else {self.parameters = [:]}
        method = requestedMethod
        url = "https://apiecho.cf/api/" + "\(requestedUrlType)"
        if let isheaders = headers {
            self.headers = isheaders
        } else {self.headers = [:]}
    }

    func requestDataWithParameters(result : @escaping (ResponseWithParameters?) -> Void){
        Alamofire.request(url, method: method, parameters: parameters).responseJSON {
            response in
            do {
                let responseData = response.data
                let user = try JSONDecoder().decode(ResponseWithParameters.self, from: responseData!)
                result(user)
            }
            catch let error {print(error)}
        }
    }
   
    func requestDataWithHeader(result : @escaping (ResponseWithToken?) -> Void){
        Alamofire.request (url, method: .get, headers: headers)
            .responseJSON { response in
                do {
                    let responseData = response.data
                    let responseDataValue = try JSONDecoder().decode(ResponseWithToken.self, from: responseData!)
                    result(responseDataValue)
                }
                catch let error {print(error)}
        }
    }
}

