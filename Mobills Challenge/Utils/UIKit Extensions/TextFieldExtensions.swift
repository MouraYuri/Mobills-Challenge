//
//  TextFieldExtensions.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
import UIKit

extension UITextField {
    
    func addToolbarToTextFields(doneFunction: Selector){
        let screenWidth = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Ok", style: .plain, target: target, action: doneFunction)
        toolBar.setItems([flexible, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
