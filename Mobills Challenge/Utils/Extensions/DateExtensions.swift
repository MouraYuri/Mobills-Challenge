//
//  DateExtensions.swift
//  Mobills Challenge
//
//  Created by Yuri Moura on 07/10/20.
//

import Foundation
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
