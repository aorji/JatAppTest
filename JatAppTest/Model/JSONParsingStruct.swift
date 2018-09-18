//
//  JSONParsing.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation

struct ResponseWithParameters: Codable {
    let errors: [ErrorWithParameters]
    let data: User?
    let success: Bool
}

struct User: Codable {
    let status: Int?
    let name, email: String?
    let updatedAt: Int?
    let accessToken: String?
    let createdAt, role, uid: Int?
    
    enum CodingKeys: String, CodingKey {
        case status, name, email
        case updatedAt = "updated_at"
        case accessToken = "access_token"
        case createdAt = "created_at"
        case role, uid
    }
}

struct ErrorWithParameters: Codable {
    let message: String
}

struct ResponseWithToken: Codable {
    let success: Bool
    let data: String
    let errors: [ErrorWithToken]
}

struct ErrorWithToken: Codable {
    let name, message: String
    let code, status: Int
}

func updateTextFieldWithError(errors : [ErrorWithParameters]) -> String{
    
    var errorMessage = ""
    
    for message in errors {
        errorMessage = errorMessage + "\n" +  String(describing: message.message)
    }
    return errorMessage
}
