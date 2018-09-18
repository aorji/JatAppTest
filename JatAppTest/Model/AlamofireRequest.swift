//
//  AlamofireRequest.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequestWithParameters {

    let parameters : [String : String]
    let method : HTTPMethod
    let url : String

    init(params : [String : String], requestedMethod : HTTPMethod, requestedUrlType : String){
        parameters = params
        method = requestedMethod
        url = "https://apiecho.cf/api/" + "\(requestedUrlType)"
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
   
}

