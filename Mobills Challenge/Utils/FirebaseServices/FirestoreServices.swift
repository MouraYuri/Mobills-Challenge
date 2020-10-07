//
//  FirestoreServices.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
import Firebase

class FirestoreServices {
    
    static let shared = FirestoreServices()
    
    private init(){}
    
    let database = Firestore.firestore()
    
    func getDocuments(collection: Collection, completion: @escaping (([Any]?,String?) -> Void)){
        self.database.collection(collection.rawValue).getDocuments { (query, error) in
            if let _ = error {
                completion(nil, error.debugDescription)
            } else {
                if collection.rawValue == "Users" {
                    let users = self.parseDocumentsToUserType(documents: query!.documents)
                    completion(users, nil)
                } else {
                    let transactions = self.parseDocumentsToTransactionType(documents: query!.documents)
                    completion(transactions, nil)
                }
                
            }
            
        }
    }
    
    func queryTransactionsForAUser(userID: String, completion: @escaping (([Transaction]?, String?) -> Void)){
        self.database.collection("Users").whereField("user", isEqualTo: userID).getDocuments { (query, error) in
            if let _ = error {
                completion(nil, error.debugDescription)
            } else {
                let transactions = self.parseDocumentsToTransactionType(documents: query!.documents)
                completion(transactions, nil)
            }
        }
    }
    
    private func parseDocumentsToUserType(documents: [QueryDocumentSnapshot]) -> [User]{
        var users: [User] = []
        for document in documents{
            users.append(User(document: document))
        }
        return users
    }
    
    private func parseDocumentsToTransactionType(documents: [QueryDocumentSnapshot]) -> [Transaction]{
        var transactions: [Transaction] = []
        for document in documents{
            transactions.append(Transaction(document: document))
        }
        return transactions
    }
}
