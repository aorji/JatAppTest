//
//  JSONParsing.swift
//  JatAppTest
//
//  Created by Anastasiia ORJI on 9/16/18.
//  Copyright © 2018 Anastasiia ORJI. All rights reserved.
//

import Foundation

struct Response: Codable {
    let errors: [Error]
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

struct Error: Codable {
    let message: String
}

