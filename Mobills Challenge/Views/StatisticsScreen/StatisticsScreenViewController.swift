//
//  StatisticsScreenViewController.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 08/10/20.
//

import UIKit
import Charts

enum VisualizationType {
    case simple
    case complex
}

class StatisticsScreenViewController: UIViewController {
    
    var transactions: [Transaction] = [] {
        didSet {
            self.getRevenueAndExpenseTotalValues()
        }
    }
    
    var currentVisualizationType = VisualizationType.simple
    
    let viewModel = StatisticsScreenViewModel()
    
    var expensesTransactionsTotalValue: Double = 0.0
    var revenuesTransactionsTotalValue: Double = 0.0
    
    var paidExpensesTransactionsTotalValue: Double = 0.0
    var notPaidExpensesTransactionsTotalValue: Double = 0.0
    var receivedRevenueTransactionsTotalValue: Double = 0.0
    var notReceivedRevenueTransactionsTotalValue: Double = 0.0
    
    let revenuesDataEntry = PieChartDataEntry(value: 0)
    let expensesDataEntry = PieChartDataEntry(value: 0)
    
    let paidExpensesDataEntry = PieChartDataEntry(value: 0)
    let notPaidExpensesDataEntry = PieChartDataEntry(value: 0)
    let receivedRevenuesDataEntry = PieChartDataEntry(value: 0)
    let notReceivedRevenuesDataEntry = PieChartDataEntry(value: 0)
    
    var dataEntries = [PieChartDataEntry]()
    
    @IBOutlet weak var pieChart: PieChartView!
    
    @IBOutlet weak var expenseTotalValueLabel: UILabel!
    
    @IBOutlet weak var revenuesTotalValueLabel: UILabel!
    
    @IBOutlet weak var changeVisualizationButton: UIButton!
    
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
        
        self.paidExpensesTransactionsTotalValue = getPaidExpensesTransactionsTotalValue(of: self.transactions)
        self.notPaidExpensesTransactionsTotalValue = getNotPaidExpensesTransactionsTotalValue(of: self.transactions)
        
        self.receivedRevenueTransactionsTotalValue = getReceivedRevenueTransactionsTotalValue(of: self.transactions)
        self.notReceivedRevenueTransactionsTotalValue = getNotReceivedRevenueTransactionsTotalValue(of: self.transactions)
        
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
    
    private func getPaidExpensesTransactionsTotalValue(of transactions: [Transaction]) -> Double {
        var ret: Double = 0.0
        for transaction in transactions{
            ret += (transaction.transactionType == "Despesa" && transaction.status == "Pago") ? transaction.value : 0
        }
        return ret
    }
    
    private func getNotPaidExpensesTransactionsTotalValue(of transactions: [Transaction]) -> Double {
        var ret: Double = 0.0
        for transaction in transactions{
            ret += (transaction.transactionType == "Despesa" && transaction.status != "Pago") ? transaction.value : 0
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
    
    private func getReceivedRevenueTransactionsTotalValue(of transactions: [Transaction]) -> Double {
        var ret: Double = 0.0
        for transaction in transactions{
            ret += (transaction.transactionType == "Receita" && transaction.status == "Recebido") ? transaction.value : 0
        }
        return ret
    }
    
    private func getNotReceivedRevenueTransactionsTotalValue(of transactions: [Transaction]) -> Double {
        var ret: Double = 0.0
        for transaction in transactions{
            ret += (transaction.transactionType == "Receita" && transaction.status != "Recebido") ? transaction.value : 0
        }
        return ret
    }
    
    func setupPieChart(){
        if self.currentVisualizationType == .simple {
            self.pieChart.chartDescription?.text = "Transações"
            self.expensesDataEntry.label = "Despesas"
            self.expensesDataEntry.value = self.expensesTransactionsTotalValue
            
            self.revenuesDataEntry.label = "Receitas"
            self.revenuesDataEntry.value = self.revenuesTransactionsTotalValue
            
            self.dataEntries = [expensesDataEntry, revenuesDataEntry]
        } else {
            self.pieChart.chartDescription?.text = "Transações"
            
            self.paidExpensesDataEntry.label = "Despesas Pagas"
            self.paidExpensesDataEntry.value = self.paidExpensesTransactionsTotalValue
            
            self.notPaidExpensesDataEntry.label = "Despesas \nNão Pagas"
            self.notPaidExpensesDataEntry.value = self.notPaidExpensesTransactionsTotalValue
            
            self.receivedRevenuesDataEntry.label = "Receitas Recebidas"
            self.receivedRevenuesDataEntry.value = self.receivedRevenueTransactionsTotalValue
            
            self.notReceivedRevenuesDataEntry.label = "Receitas \nNão Recebidas"
            self.notReceivedRevenuesDataEntry.value = self.notReceivedRevenueTransactionsTotalValue
            
            self.dataEntries = [paidExpensesDataEntry, notPaidExpensesDataEntry, receivedRevenuesDataEntry, notReceivedRevenuesDataEntry]
        }
        
        self.updateChartData()
    }
    
    func updateChartData(){
        let chartDataSet = PieChartDataSet(entries: self.dataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.entryLabelColor = UIColor.black as NSUIColor
        pieChart.entryLabelFont = NSUIFont.boldSystemFont(ofSize: 16)
        var colors: [UIColor] = []
        if self.currentVisualizationType == .simple {
            colors = [UIColor(red: 94/255, green: 6/255, blue: 31/255, alpha: 1.0), UIColor.blue]
        } else {
            colors = [UIColor.purple, UIColor.brown, UIColor.blue, UIColor.cyan]
        }
        chartDataSet.colors = colors
        self.pieChart.data = chartData
    }
    
    func setupTotalValueLabels(totalExpensesValue: Double, totalRevenueValues: Double) {
        self.expenseTotalValueLabel.text = "R$ \(totalExpensesValue)"
        self.expenseTotalValueLabel.textColor = .red
        self.revenuesTotalValueLabel.text = "R$ \(totalRevenueValues)"
        self.revenuesTotalValueLabel.textColor = .blue
    }
    
    
    @IBAction func didTapChangeVisualizationButton(_ sender: UIButton) {
        self.currentVisualizationType = currentVisualizationType == .simple ? .complex : .simple
        self.setupPieChart()
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
