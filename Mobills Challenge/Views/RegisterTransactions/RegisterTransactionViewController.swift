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
        
        self.valueTextField.addToolbarToTextFields(doneFunction: #selector(didTapDone))
    }
    
    func setupDatePicker(){
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 400))
        datePicker.datePickerMode = .date
        self.dateTextField.inputView = datePicker
        self.dateTextField.addToolbarToTextFields(doneFunction: #selector(didTapDone))
    }
    
    
    
    @objc func didTapDone(){
        self.resignFirstResponder()
    }
    
    
    func setupTextFieldsDelegates(){
        self.descriptionTextField.delegate = self
        self.valueTextField.delegate = self
        self.dateTextField.delegate = self
    }
    
    
    @IBAction func didChangeSegmentedControlOption(_ sender: UISegmentedControl) {
        
        let segmentedControlCurrentStringValue = self.transactionOptionsSegmentedControl.titleForSegment(at: self.transactionOptionsSegmentedControl.selectedSegmentIndex)
        
        let newLabelString: String = {
            switch segmentedControlCurrentStringValue {
            case "Receita":
                return "A receita foi recebida?"
            default:
                return "A despesa foi paga?"
            }
        }()
        
        DispatchQueue.main.async {
            self.labelBelowSegmentedControl.text = newLabelString
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
