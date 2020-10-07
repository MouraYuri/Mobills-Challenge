//
//  MainScreenViewModel.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
import Firebase

protocol ViewModelDelegate: class {
    func didFinishFetching(values: [Any])
    func didFinishFetchingWithError(message: String)
}

class MainScreenViewModel {
    
    weak var viewModelDelegate: ViewModelDelegate?
    
    func getTransactions(userID: String){
        FirestoreServices.shared.getTransactionsForAUser(userID: userID) { (transactions, error) in
            if let err = error {
                self.viewModelDelegate?.didFinishFetchingWithError(message: err)
                return
            } else {
                if let transactions = transactions {
                    self.viewModelDelegate?.didFinishFetching(values: transactions)
                }
                return
            }
        }
    }
}
