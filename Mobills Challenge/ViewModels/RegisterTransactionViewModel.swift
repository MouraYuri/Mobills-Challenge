//
//  RegisterTransactionViewModel.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation

enum Collection: String {
    case user = "Users"
    case transactions = "Transactions"
}


class RegisterTransactionViewModel {
    
    func getUsers(){
        FirestoreServices.shared.getDocuments(collection: .transactions) { (documents, error) in
            
        }
    }
}
