//
//  User.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int!
    var firstName: String!
    var lastName: String!
    var nick: String!
    var email: String!
    var avatarUrl: String!
    
    required init?() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        nick <- map["nick"]
        email <- map["email"]
        avatarUrl <- map["attachment.url"]
    }
}
