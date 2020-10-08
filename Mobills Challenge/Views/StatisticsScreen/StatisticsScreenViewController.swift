//
//  StatisticsScreenViewController.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 08/10/20.
//

import UIKit
import Charts

class StatisticsScreenViewController: UIViewController {
    
    var transactions: [Transaction] = [] {
        didSet {
            self.getRevenueAndExpenseTotalValues()
        }
    }
    
    let viewModel = StatisticsScreenViewModel()
    
    var expensesTransactionsTotalValue: Double = 0.0
    var revenuesTransactionsTotalValue: Double = 0.0
    
    let revenuesDataEntry = PieChartDataEntry(value: 0)
    let expensesDataEntry = PieChartDataEntry(value: 0)
    
    var dataEntries = [PieChartDataEntry]()
    
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.statisticsScreenViewModelDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getTransactions(userID: "Users/GnR7KuYTyzX14sW2ReDt")
    }
    
    private func getRevenueAndExpenseTotalValues() {
        self.expensesTransactionsTotalValue = getExpensesTransactionsTotalValue(of: self.transactions)
        self.revenuesTransactionsTotalValue = getRevenueTransactionsTotalValue(of: self.transactions)
        setupPieChat()
    }

    private func getExpensesTransactionsTotalValue(of transactions: [Transaction]) -> Double {
        var ret: Double = 0.0
        for transaction in transactions{
            ret += transaction.transactionType == "Despesa" ? transaction.value : 0
        }
        return ret
    }
    
    private func getRevenueTransactionsTotalValue(of transactions: [Transaction]) -> Double {
        var ret: Double = 0.0
        for transaction in transactions{
            ret += transaction.transactionType == "Receita" ? transaction.value : 0
        }
        return ret
    }
    
    func setupPieChat(){
        self.pieChart.chartDescription?.text = "Transações"
        self.expensesDataEntry.label = "Despesas"
        self.expensesDataEntry.value = self.expensesTransactionsTotalValue
        
        self.revenuesDataEntry.label = "Receitas"
        self.revenuesDataEntry.value = self.revenuesTransactionsTotalValue
        
        self.dataEntries = [expensesDataEntry, revenuesDataEntry]
        
        self.updateChartData()
    }
    
    func updateChartData(){
        let chartDataSet = PieChartDataSet(entries: self.dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor.red, UIColor.green]
        chartDataSet.colors = colors
        self.pieChart.data = chartData
    }
}

extension StatisticsScreenViewController: FetchTransactionsDelegate {
    func didFinishFetching(values: [Any]) {
        if let transactions = values as? [Transaction] {
            self.transactions = transactions
        }
    }
    
    func didFinishFetchingWithError(message: String) {
        
    }
    
    
}
