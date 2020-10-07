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
        
    }
    
}


