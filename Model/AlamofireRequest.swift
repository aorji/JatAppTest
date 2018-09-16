//
//  AlamofireRequest.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AlamofireRequest {

    let parameters : [String : String]
    let method : HTTPMethod
    let url : String

    init(params : [String : String], requestMethod : HTTPMethod, requestUrlType : String){
        parameters = params
        method = requestMethod
        url = "https://apiecho.cf/api/" + "\(requestUrlType)"
    }

    func requestData(result : @escaping (Response?) -> Void){
        Alamofire.request(url, method: method, parameters: parameters).responseJSON {
            response in
            do {
                let responseData = response.data
                let user = try JSONDecoder().decode(Response.self, from: responseData!)
                result(user)
            }
            catch let error {print(error)}
        }
    }

}

