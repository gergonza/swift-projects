//
//  Data.swift
//  Networking
//
//  Created by Germán González on 11/6/23.
//

import Foundation

/*
 {
    "code":200,
    "meta":null,
    "data":{
       "id":1718,
       "name":"Rita Guneta",
       "email":"rita_guneta@denesik.net",
       "gender":"female",
       "status":"inactive"
    }
 }
*/

struct UserResponse:Decodable {
    
    let code:Int?
    let meta:Meta?
    let data:User?
}

struct User:Decodable {
    
    let id:Int?
    let name:String?
    let email:String?
    let gender:String?
    let status:String?
    
    // Enum to emulate JsonProperty Java Spring Tag
    enum CodingKeys:String, CodingKey {
        case id
        case name
        case email
        case gender
        case status
        // case created_at = "createdAt"
        // case updated_at = "updatedAt"
    }
}

struct Meta:Decodable {
    
}
