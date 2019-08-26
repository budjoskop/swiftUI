//
//  Date-extension.swift
//  passDataDelegate
//
//  Created by ognjen on 1/30/19.
//  Copyright © 2019 ognjen. All rights reserved.
//

import Foundation



extension Date {
    
    
    func firstAndLastDate () -> (String, String, String, String, String) {
        
        var dateForInvoice = ""
        var invoiceNumber = ""

        // Set calendar and date
        let calendar = Calendar.current
        let date = calendar.date(byAdding: DateComponents(day: 0), to: Date())!
        
        // Get range of days in month
        let range = calendar.range(of: .day, in: .month, for: date)! // Range(1..<32)
        
        // Get first day of month
        var firstDayComponents = calendar.dateComponents([.year, .month], from: date)
        firstDayComponents.day = range.lowerBound
        let firstDay = calendar.date(from: firstDayComponents)!
        
        // Get last day of month
        var lastDayComponents = calendar.dateComponents([.year, .month], from: date)
        lastDayComponents.day = range.upperBound - 1
        //lastDayComponents.day = range.count // also works
        let lastDay = calendar.date(from: lastDayComponents)!
        
        // Set date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        
         let todayDate = dateFormatter.string(from: date)
        
        //variables for method to replace date ranges in template
        let last = dateFormatter.string(from: lastDay)
        let first = dateFormatter.string(from: firstDay)
        
        //Setting invoice number
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)

        
        dateForInvoice = "\(month)"
        invoiceNumber = "\(month)/\(year)"
        dateForInvoice = String(month + 1)
        
         return (dateForInvoice, invoiceNumber, first, last, todayDate)
    }
    
}
