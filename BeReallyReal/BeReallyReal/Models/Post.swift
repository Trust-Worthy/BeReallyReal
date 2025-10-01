//
//  Models/Post.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 9/30/25.
//

import Foundation
import ParseSwift

struct Post: ParseObject {
    
    // required by parse object
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
    // custom properties
    var caption: String?
    var user: User?
    var imageFile: ParseFile?
}
