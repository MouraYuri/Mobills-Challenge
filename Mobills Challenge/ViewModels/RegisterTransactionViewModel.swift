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
    
    func registerNewTransaction(_ newTransaction: [String:Any]){
        FirestoreServices.shared.saveNewTransaction(newTransaction) { (error) in
            if let _ = error {
                print(error)
            } else {
                print("Succesfully added!!")
            }
        }
    }
}
