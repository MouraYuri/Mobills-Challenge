//
//  RegisterTransactionViewController.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import UIKit

class RegisterTransactionViewController: UIViewController {

    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var labelBelowSegmentedControl: UILabel!
    
    @IBOutlet weak var transactionOptionsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var finalizeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextFieldsDelegates()
        setupDatePicker()
        
        self.valueTextField.addToolbarToTextFields(doneAction: #selector(didTapDone), cancelAction: #selector(didTapCancel), barButtonTag: 0)
    }
    
    func setupDatePicker(){
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 400))
        datePicker.datePickerMode = .date
        self.dateTextField.inputView = datePicker
        self.dateTextField.addToolbarToTextFields(doneAction: #selector(didTapDone), cancelAction: #selector(didTapCancel), barButtonTag: 1)
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
    
    
    @IBAction func didChangeSegmentedControlOption(_ sender: UISegmentedControl) {
        
        guard let segmentedControlCurrentStringValue = self.transactionOptionsSegmentedControl.titleForSegment(at: self.transactionOptionsSegmentedControl.selectedSegmentIndex) else {
            return
        }
        
        let newLabelString: String = getNewLabelString(segmentedControlCurrentStringValue)
        
        DispatchQueue.main.async {
            self.labelBelowSegmentedControl.text = newLabelString
        }
    }
    
    func getNewLabelString(_ segmentedControlCurrentStringValue: String) -> String {
        switch segmentedControlCurrentStringValue {
        case "Receita":
            return "A receita foi recebida?"
        default:
            return "A despesa foi paga?"
        }
    }
    
    
    @IBAction func didTapFinalizeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterTransactionViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
