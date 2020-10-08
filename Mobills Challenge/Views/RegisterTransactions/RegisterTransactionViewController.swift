//
//  RegisterTransactionViewController.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import UIKit

class RegisterTransactionViewController: UIViewController {
    
    var transactionDict: [String:Any] = [
        "type":"Despesa",
        "description":"Pago",
        "value":0.0,
        "data":Date(),
        "status":"",
        "user":"GnR7KuYTyzX14sW2ReDt"
    ]
    
    var updatingValues: Bool = false
    
    var transactionToBeEdited: Transaction?
    
    let viewModel = RegisterTransactionViewModel()

    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var labelBelowSegmentedControl: UILabel!
    
    @IBOutlet weak var transactionOptionsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var finalizeButton: UIButton!
    
    @IBOutlet weak var transactionStatusSwitch: UISwitch!
    
    @IBOutlet weak var excludeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.registerTransactionViewModelDelegate = self
        
        if self.updatingValues{
            if let transaction = transactionToBeEdited {
                prepareViewControllerToEdit(with: transaction)
            }
        }
        setupTextFieldsDelegates()
        setupDatePicker()
        
        self.valueTextField.addToolbarToTextField(doneAction: #selector(didTapDone), cancelAction: #selector(didTapCancel), barButtonTag: 0)
    }
    
    func setupDatePicker(){
        self.dateTextField.addDatePickerAsInputView(datePickerMode: .date, selector: #selector(datePickerValueChanged), target: self)
        self.dateTextField.addToolbarToTextField(doneAction: #selector(didTapDone), cancelAction: #selector(didTapCancel), barButtonTag: 1)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.dateTextField.text = dateFormatter.string(from: sender.date)
        setupDateValue(sender.date)
    }
    
    
    
    private func prepareViewControllerToEdit(with transaction: Transaction){
        self.descriptionTextField.text = transaction.description
        self.valueTextField.text = String(transaction.value)
        self.dateTextField.text = transaction.date.toString(dateFormat: "dd/MM/yyyy")
        
        switch transaction.transactionType {
        case "Receita":
            self.transactionOptionsSegmentedControl.selectedSegmentIndex = 1
            self.transactionStatusSwitch.isOn = transaction.status == "Recebido" ? true : false
        default:
            self.transactionStatusSwitch.isOn = transaction.status == "Pago" ? true : false
        }
        
        updatelabelBelowSegmentedControlText()
        self.excludeButton.isHidden = false
    }
    
    
    @IBAction func didTapExcludeButton(_ sender: UIButton) {
        if let transaction = self.transactionToBeEdited {
            viewModel.deleteTransaction(transaction.documentID)
        }
    }
    
    @objc func didTapDone(sender: UIBarButtonItem){
        guard let textField = getTextFieldReferenceByTag(tag: sender.tag) else {
            return
        }
        textField.resignFirstResponder()
    }
    
    @objc func didTapCancel(sender: UIBarButtonItem){
        guard let textField = getTextFieldReferenceByTag(tag: sender.tag) else {
            return
        }
        textField.clearTextFieldContent()
        textField.resignFirstResponder()
    }
    
    func getTextFieldReferenceByTag(tag: Int) -> UITextField?{
        switch tag {
            case 0:
                return self.valueTextField
            case 1:
                return self.dateTextField
            default:
                return nil
        }
    }
    
    func setupTextFieldsDelegates(){
        self.descriptionTextField.delegate = self
        self.valueTextField.delegate = self
        self.dateTextField.delegate = self
    }
    
    func updateNewTransactionStatusAndType(){
        guard let segmentedControlCurrentStringValue = self.getSegmentedControlCurrentStringValue() else {
            return
        }
        if segmentedControlCurrentStringValue == "Despesa" {
            self.transactionDict["type"] = "Despesa"
            self.transactionDict["status"] = transactionStatusSwitch.isOn ? "Pago" : "Não Pago"
        } else {
            self.transactionDict["type"] = "Receita"
            self.transactionDict["status"] = transactionStatusSwitch.isOn ? "Recebido" : "Não Recebido"
        }
    }
    
    @IBAction func didChangeSegmentedControlOption(_ sender: UISegmentedControl) {
        updatelabelBelowSegmentedControlText()
    }
    
    func updatelabelBelowSegmentedControlText(){
        guard let segmentedControlCurrentStringValue = getSegmentedControlCurrentStringValue() else {
            return
        }
        
        let newLabelString: String = getLabelBelowSegmentedControlNewString(segmentedControlCurrentStringValue)
        
        DispatchQueue.main.async {
            self.labelBelowSegmentedControl.text = newLabelString
        }
    }
    
    func getSegmentedControlCurrentStringValue() -> String? {
        return self.transactionOptionsSegmentedControl.titleForSegment(at: self.transactionOptionsSegmentedControl.selectedSegmentIndex)
    }
    
    func getLabelBelowSegmentedControlNewString(_ segmentedControlCurrentStringValue: String) -> String {
        switch segmentedControlCurrentStringValue {
        case "Receita":
            return "A receita foi recebida?"
        default:
            return "A despesa foi paga?"
        }
    }
    
    func getValueTextFieldTextFormatted() -> String{
        guard let currentTextFieldValue = self.valueTextField.text else{
            return ""
        }
        return currentTextFieldValue != "" ? "R$ \(currentTextFieldValue)" : ""
    }
    
    func getDateTextFieldTextAsDate() -> Date{
        if let dateTextFieldText = self.dateTextField.text {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let newDateValue = formatter.date(from: dateTextFieldText) ?? Date()
            return newDateValue
        }
        return Date()
    }
    
    func setupDateValue(_ newValue: Date){
        self.transactionDict["data"] = newValue
    }
    
    func setupTransactionValue(_ newValue: String?){
        let newValueSplitted = newValue?.split(separator: " ")
        var value: Double = 0.0
        if newValueSplitted?.count ?? 0 < 2 {
            if let newValue = newValue {
                value = Double(newValue) ?? 0.0
            }
        } else {
            if let temp = newValueSplitted?[1] {
                value = Double(temp) ?? 0.0
            }
        }
        self.transactionDict["value"] = value
    }
    
    func setupDescriptionValue(_ newValue: String?){
        self.transactionDict["description"] = newValue
    }
    
    @IBAction func didTapFinalizeButton(_ sender: UIButton) {
        self.registerNewTransaction()
    }
    
    func registerNewTransaction(){
        self.updateNewTransactionStatusAndType()
        if !self.updatingValues{
            self.viewModel.registerNewTransaction(self.transactionDict)
        } else {
            if let documentID = self.transactionToBeEdited?.documentID {
                
                setupDescriptionValue(descriptionTextField.text)
                setupTransactionValue(valueTextField.text)
                
                setupDateValue(getDateTextFieldTextAsDate())
                
                self.viewModel.updateExistingTransaction(self.transactionDict, transactionID: documentID)
            }
        }
    }
}

extension RegisterTransactionViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
            case 0:
                setupTransactionValue(textField.text)
                self.valueTextField.text = getValueTextFieldTextFormatted()
            case 3:
                setupDescriptionValue(textField.text)
            default:
                return
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
            case 0:
                textField.text = nil
            default:
                return
        }
    }
}

extension RegisterTransactionViewController: RegisterTransactionViewModelDelegate{
    func didFinishAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didFinishActionWithError(error: String) {
        
    }
}
