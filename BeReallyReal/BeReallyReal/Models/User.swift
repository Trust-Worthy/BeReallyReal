//
//  Models/User.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 9/30/25.
//

import Foundation
import ParseSwift

struct User: ParseUser {
    
    // required by 'Parse Object'
    
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?
    
    // required by ParseUser
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String : [String : String]?]?
    
}
