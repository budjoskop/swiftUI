//
//  InvoiceComposser.swift
//  Invoice Composer
//
//  Created by ognjen on 11/7/18.
//  Copyright © 2018 ognjen. All rights reserved.
//

import UIKit
import MessageUI
import Foundation

class InvoiceComposserModel: NSObject {
    
    let pathToInvoiceHTMLTemplate = Bundle.main.path(forResource: "invoiceTemplate", ofType: "html")
    
    var invoiceNumber:String!
    var invoiceNumberPreview:String!
    var price:String!
    var pdfFilename:String!
    var pdfFile:NSData!
    var valueEur:String!
    var invoiceDate:String!
    var firstDayOfCurrentMonth:String!
    var lastDayOfCurrentMonth:String!
    var lastDateForPayOff:String!
    var wwwUrl: URL!
    
    
    override init() {
        super.init()
        
    }
    
    
    func renderInvoice (cena:String, eurValue:String, invoice:String, firstDate:String, lastDate:String, invoiceNumberOnDocument:String, lastDatePayoff:String) -> String! {
        
        self.price = cena
        self.valueEur = eurValue
        self.invoiceDate = invoice
        self.firstDayOfCurrentMonth = firstDate
        self.lastDayOfCurrentMonth = lastDate
        self.invoiceNumberPreview = invoiceNumberOnDocument
        self.lastDateForPayOff = lastDatePayoff
        
        do {
            var HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#PRICE#", with: price)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#COURSE#", with: valueEur)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#INVOICEDATE#", with: invoiceDate)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FIRSTDATE#", with: firstDayOfCurrentMonth)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LASTDATE#", with: lastDayOfCurrentMonth)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#INVOICENUMBER#", with: invoiceNumberPreview)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#MONTH#", with: lastDateForPayOff)
            
            // Conversion from string to URL
            wwwUrl = URL(string: pathToInvoiceHTMLTemplate!)
            
            return HTMLContent
        } catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
        
    }
    
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        
        UIGraphicsBeginPDFPage()
        
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        pdfFile = pdfData
        
        // Set calendar and date
        let calendar = Calendar.current
        let date = calendar.date(byAdding: DateComponents(day: 0), to: Date())!
        
        //Setting invoice number
        let month = calendar.component(.month, from: date)
        
         pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Spec \(month)/2019.pdf"
        
        
        pdfData!.write(toFile: pdfFilename, atomically: true)
        
        
    }
    
}

