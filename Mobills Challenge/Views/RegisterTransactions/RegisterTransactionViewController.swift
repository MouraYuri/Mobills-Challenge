//
//  RegisterTransactionViewController.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import UIKit

class RegisterTransactionViewController: UIViewController {
    
    var newTransaction: [String:Any] = [
        "type":"Despesa",
        "description":"Pago",
        "value":0.0,
        "data":Date(),
        "status":"",
        "user":"GnR7KuYTyzX14sW2ReDt"
    ]
    
    let viewModel = RegisterTransactionViewModel()

    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var labelBelowSegmentedControl: UILabel!
    
    @IBOutlet weak var transactionOptionsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var finalizeButton: UIButton!
    
    @IBOutlet weak var transactionStatusSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFieldsDelegates()
        setupDatePicker()
        
        self.valueTextField.addToolbarToTextField(doneAction: #selector(didTapDone), cancelAction: #selector(didTapCancel), barButtonTag: 0)
    }
    
    func setupDatePicker(){
        self.dateTextField.addInputViewAsDatePicker(datePickerMode: .date)
        self.dateTextField.addToolbarToTextField(doneAction: #selector(didTapDone), cancelAction: #selector(didTapCancel), barButtonTag: 1)
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
            self.newTransaction["type"] = "Despesa"
            self.newTransaction["status"] = transactionStatusSwitch.isOn ? "Pago" : "Não Pago"
        } else {
            self.newTransaction["type"] = "Receita"
            self.newTransaction["status"] = transactionStatusSwitch.isOn ? "Recebido" : "Não Recebido"
        }
    }
    
    
    @IBAction func didChangeSegmentedControlOption(_ sender: UISegmentedControl) {
        guard let segmentedControlCurrentStringValue = self.getSegmentedControlCurrentStringValue() else {
            return
        }
        let newLabelString: String = getLabelBelowSegmentedControlNewString(segmentedControlCurrentStringValue)
        
        DispatchQueue.main.async {
            self.labelBelowSegmentedControl.text = newLabelString
        }
    }
    
    @IBAction func didChangeStatusSwitchValue(_ sender: UISwitch) {
        /*
         
         REMOVE THIS LATER
         
         */
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
    
    
    @IBAction func didTapFinalizeButton(_ sender: UIButton) {
        self.registerNewTransaction()
        self.dismiss(animated: true, completion: nil)
    }
    func registerNewTransaction(){
        self.updateNewTransactionStatusAndType()
        self.viewModel.registerNewTransaction(self.newTransaction)
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
                let value = Double(textField.text ?? "0.0")
                self.newTransaction["value"] = value
                self.valueTextField.text = getValueTextFieldTextFormatted()
            case 3:
                self.newTransaction["description"] = self.descriptionTextField.text
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
