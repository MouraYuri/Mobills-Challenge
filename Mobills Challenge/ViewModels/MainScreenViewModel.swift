//
//  MainScreenViewModel.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
import Firebase

protocol FetchTransactionsDelegate: class {
    func didFinishFetching(values: [Any])
    func didFinishFetchingWithError(message: String)
}

class MainScreenViewModel {
    
    weak var mainScreenViewModelDelegate: FetchTransactionsDelegate?
    
    func getTransactions(userID: String){
        FirestoreServices.shared.getTransactionsForAUser(userID: userID) { (transactions, error) in
            if let err = error {
                self.mainScreenViewModelDelegate?.didFinishFetchingWithError(message: err)
                return
            } else {
                if let transactions = transactions {
                    self.mainScreenViewModelDelegate?.didFinishFetching(values: transactions)
                }
                return
            }
        }
    }
    
    func deleteTransaction(_ transactionID: String){
        FirestoreServices.shared.deleteTransaction(transactionID: transactionID) { (error) in
            if let _ = error {
                self.mainScreenViewModelDelegate?.didFinishFetchingWithError(message: error ?? "Ocorreu um erro")
            }
        }
    }
}
