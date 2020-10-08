//
//  MainScreenViewController.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 06/10/20.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    var transactionsArray: [Transaction] = [] {
        didSet {
            self.noDataLabel.isHidden = self.transactionsArray.isEmpty ? false : true
            self.tableView.reloadData()
        }
    }
    
    let viewModel = MainScreenViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.viewModel.mainScreenViewModelDelegate = self
        self.navigationItem.title = "Mobills Challenge"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getTransactions(userID: "Users/GnR7KuYTyzX14sW2ReDt")
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TransactionsTableViewCell.self, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
        self.tableView.separatorStyle = .none
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    @IBAction func didTapAddButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "RegisterTransaction", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterTransaction")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier) as? TransactionsTableViewCell else {
            return UITableViewCell()
        }
        let transaction = self.transactionsArray[indexPath.row]
        cell.config(transaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight/8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let transaction = self.transactionsArray[indexPath.row]
        let storyboard = UIStoryboard(name: "RegisterTransaction", bundle: Bundle.main)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "RegisterTransaction") as? RegisterTransactionViewController {
            viewController.updatingValues = true
            viewController.transactionToBeEdited = transaction
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let transaction = self.transactionsArray[indexPath.row]
        switch editingStyle {
            case .delete:
                self.transactionsArray.remove(at: indexPath.row)
                self.tableView.reloadData()
                self.viewModel.deleteTransaction(transaction.documentID)
            default:
                return
        }
    }
}

extension MainScreenViewController: MainScreenViewModelDelegate {
    func didFinishFetching(values: [Any]) {
        guard let transactions = values as? [Transaction] else {
            return
        }
        self.transactionsArray = transactions
    }
    
    func didFinishFetchingWithError(message: String) {
        
    }
    
}
