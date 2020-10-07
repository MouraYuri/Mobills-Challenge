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
            self.tableView.reloadData()
        }
    }
    
    let viewModel = MainScreenViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.viewModel.viewModelDelegate = self
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionsArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
}

extension MainScreenViewController: ViewModelDelegate {
    func didFinishFetching(values: [Any]) {
        guard let transactions = values as? [Transaction] else {
            return
        }
        self.transactionsArray = transactions
    }
    
    func didFinishFetchingWithError(message: String) {
        showAlertWithErrorMessage(message)
    }
    
    
    func showAlertWithErrorMessage(_ message: String){
    }
}
