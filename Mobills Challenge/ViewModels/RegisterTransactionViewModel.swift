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
                
            } else {
                print("Succesfully added!!")
            }
        }
    }
    
    func updateExistingTransaction(_ transaction: [String:Any], transactionID: String) {
        FirestoreServices.shared.updateExistingTransaction(transactionID: transactionID, transaction: transaction) { (error) in
            if let _ = error {
                
            } else {
                print("Succesfully Updated!!")
            }
        }
    }
    
    func deleteTransaction(_ transactionID: String) {
        FirestoreServices.shared.deleteTransaction(transactionID: transactionID) { (error) in
            if let _ = error {
                
            } else {
                print("Succesfully deleted!!")
            }
        }
    }
}
