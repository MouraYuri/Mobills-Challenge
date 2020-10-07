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

protocol RegisterTransactionViewModelDelegate: class {
    func didFinishAction()
    func didFinishActionWithError(error: String)
}

class RegisterTransactionViewModel {
    
    weak var registerTransactionViewModelDelegate: RegisterTransactionViewModelDelegate?
    
    func registerNewTransaction(_ newTransaction: [String:Any]){
        FirestoreServices.shared.saveNewTransaction(newTransaction) { [weak self] (error)  in
            self?.processFirestoreResponse(error)
        }
    }
    
    func updateExistingTransaction(_ transaction: [String:Any], transactionID: String) {
        FirestoreServices.shared.updateExistingTransaction(transactionID: transactionID, transaction: transaction) { [weak self] (error) in
            self?.processFirestoreResponse(error)
        }
    }
    
    func deleteTransaction(_ transactionID: String) {
        FirestoreServices.shared.deleteTransaction(transactionID: transactionID) { [weak self] (error) in
            self?.processFirestoreResponse(error)
        }
    }
    
    private func processFirestoreResponse(_ error: String?){
        if let _ = error {
            self.registerTransactionViewModelDelegate?.didFinishActionWithError(error: error ?? "Ocorreu um erro!!")
        } else {
            self.registerTransactionViewModelDelegate?.didFinishAction()
        }
    }
}

