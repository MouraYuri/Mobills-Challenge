//
//  TextFieldExtensions.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
import UIKit

extension UITextField {
    
    func addToolbarToTextField(doneAction: Selector, cancelAction: Selector, barButtonTag: Int){
        let screenWidth = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: target, action: cancelAction)
        let okBarButton = UIBarButtonItem(title: "Ok", style: .plain, target: target, action: doneAction)
        okBarButton.tag = barButtonTag
        cancelBarButton.tag = barButtonTag
        toolBar.setItems([cancelBarButton, flexible, okBarButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    func clearTextFieldContent(){
        self.text = nil
    }
    
    func addInputViewAsDatePicker(datePickerMode: UIDatePicker.Mode){
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 400))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
    }
}
