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
    
    @IBOutlet weak var expenseTotalValueLabel: UILabel!
    
    @IBOutlet weak var revenuesTotalValueLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.statisticsScreenViewModelDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getTransactions(userID: "Users/GnR7KuYTyzX14sW2ReDt")
    }
    
    private func getRevenueAndExpenseTotalValues() {
        let expensesTotalValue = getExpensesTransactionsTotalValue(of: self.transactions)
        let revenuesTotaValue = getRevenueTransactionsTotalValue(of: self.transactions)
        self.expensesTransactionsTotalValue = expensesTotalValue
        self.revenuesTransactionsTotalValue = revenuesTotaValue
        setupPieChart()
        setupTotalValueLabels(totalExpensesValue: expensesTotalValue, totalRevenueValues: revenuesTotaValue)
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
    
    func setupPieChart(){
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
        pieChart.entryLabelColor = UIColor.black as NSUIColor
        pieChart.entryLabelFont = NSUIFont.boldSystemFont(ofSize: 16)
        let colors = [UIColor(red: 94/255, green: 6/255, blue: 31/255, alpha: 1.0), UIColor.blue]
        chartDataSet.colors = colors
        self.pieChart.data = chartData
    }
    
    func setupTotalValueLabels(totalExpensesValue: Double, totalRevenueValues: Double) {
        self.expenseTotalValueLabel.text = "R$ \(totalExpensesValue)"
        self.expenseTotalValueLabel.textColor = .red
        self.revenuesTotalValueLabel.text = "R$ \(totalRevenueValues)"
        self.revenuesTotalValueLabel.textColor = .blue
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
