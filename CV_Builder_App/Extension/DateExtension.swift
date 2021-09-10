//
//  DateExtension.swift
//  CV_Builder_App
//
//  Created by Mangesh on 07/09/21.
//
import Foundation

extension Date {
    
    func getStringFromDate()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
    
    func getDateStringInMonthNameFormat()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
