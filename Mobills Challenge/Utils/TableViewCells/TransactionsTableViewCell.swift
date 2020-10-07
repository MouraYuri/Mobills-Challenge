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
        obj.font = .boldSystemFont(ofSize: 18)
        obj.text = "Lorem Ipsum"
        return obj
    }()
    
    lazy var dateAndStatusLabel: UILabel = {
        let obj = UILabel()
        obj.text = "04/06/2020 | Pago"
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
        self.contentView.addSubview(self.dateAndStatusLabel)
        self.contentView.addSubview(self.valueLabel)
        
        NSLayoutConstraint.activate([
            self.transactionImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.transactionImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.transactionImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2),
            self.transactionImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.transactionImage.trailingAnchor, constant: 8),
            self.descriptionLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            self.dateAndStatusLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 4),
            self.dateAndStatusLabel.leadingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor),
            self.dateAndStatusLabel.bottomAnchor.constraint(equalTo: self.transactionImage.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.valueLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.valueLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
    
    func config(){
        self.setupConstraints()
    }
}
