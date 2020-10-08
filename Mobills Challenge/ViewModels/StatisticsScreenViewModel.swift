//
//  StatisticsScreenViewModel.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 08/10/20.
//

import Foundation
class StatisticsScreenViewModel {
    
    weak var statisticsScreenViewModelDelegate: FetchTransactionsDelegate?
    
    func getTransactions(userID: String){
        FirestoreServices.shared.getTransactionsForAUser(userID: userID) { (transactions, error) in
            if let err = error {
                self.statisticsScreenViewModelDelegate?.didFinishFetchingWithError(message: err)
                return
            } else {
                if let transactions = transactions {
                    self.statisticsScreenViewModelDelegate?.didFinishFetching(values: transactions)
                }
                return
            }
        }
    }
}
