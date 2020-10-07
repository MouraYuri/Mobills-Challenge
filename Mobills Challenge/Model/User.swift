//
//  User.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
import Firebase

class User {
    let name: String
    let email: String
    let password: String
    
    init(document: [String:String]){
        self.name = document["name"] ?? "User"
        self.email = document["email"] ?? "not specified"
        self.password = document["password"] ?? "not specified"
    }
    
    init(document: QueryDocumentSnapshot){
        self.name = document["name"] as? String ?? "User"
        self.email = document["email"] as? String ?? "not specified"
        self.password = document["password"] as? String  ?? "not specified"
    }
}
