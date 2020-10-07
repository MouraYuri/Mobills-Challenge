//
//  MainScreenViewController.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 06/10/20.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupTableView()
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TransactionsTableViewCell.self, forCellReuseIdentifier: TransactionsTableViewCell.identifier)
    }
    
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsTableViewCell.identifier) as? TransactionsTableViewCell else {
            return UITableViewCell()
        }
        cell.config()
        return cell
    }
}
