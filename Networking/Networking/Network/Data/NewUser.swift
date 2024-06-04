//
//  NewUser.swift
//  Networking
//
//  Created by Germán González on 11/6/23.
//

import Foundation

struct NewUser:Encodable {
    
    let name:String?
    let email:String?
    let gender:String?
    let status:String?
}
