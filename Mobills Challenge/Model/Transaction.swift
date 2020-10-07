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
    let description: String
    let value: Double
    let date: Date
    let status: String
    let UserID: String
    
    init(document: QueryDocumentSnapshot){
        self.transactionType = document["type"] as? String ?? "Despesa"
        self.description = document["description"] as? String ?? "not specified"
        self.value = document["value"] as? Double ?? 0.0
        let temp = document["data"] as? Timestamp  ?? Timestamp()
        self.date = temp.dateValue()
        self.status = document["status"] as? String  ?? "not specified"
        self.UserID = document["user"] as? String ?? "not specified"
    }
}
