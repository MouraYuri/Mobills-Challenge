//
//  Transaction.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
import Firebase

class Transaction {
    let transactionType: String
    let descriptions: String
    let valor: Float
    let data: Date
    let status: String
    let UserID: String
    
    init(document: QueryDocumentSnapshot){
        self.transactionType = document["type"] as? String ?? "D"
        self.descriptions = document["description"] as? String ?? "not specified"
        self.valor = document["value"] as? Float  ?? 0.0
        self.data = document["data"] as? Date  ?? Date()
        self.status = document["status"] as? String  ?? "not specified"
        self.UserID = document["user"] as? String ?? "not specified"
    }
}
