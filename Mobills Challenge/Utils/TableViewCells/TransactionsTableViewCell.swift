//
//  TransactionsTableViewCell.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 06/10/20.
//

import Foundation
import UIKit

class TransactionsTableViewCell: UITableViewCell {
    
    static let identifier = "TransactionsTableViewCell"
    
    lazy var transactionImage: UIImageView = {
        let obj = UIImageView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var descriptionLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.text = "Lorem Ipsum"
        return obj
    }()
    
    lazy var dateLabel: UILabel = {
        let obj = UILabel()
        obj.text = "04/06/2020"
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var valueLabel: UILabel = {
        let obj = UILabel()
        obj.text = "R$ 15.23"
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    func setupConstraints(){
        self.contentView.addSubview(self.transactionImage)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.valueLabel)
    }
}
