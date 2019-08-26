//
//  SpecModel.swift
//  test
//
//  Created by ognjen on 23/08/2019.
//  Copyright © 2019 ognjen. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


class SpecModel: NSObject {
    
    let pathToInvoiceHTMLTemplate = Bundle.main.path(forResource: "potvrda", ofType: "html")
    
    
    
    var pdfFilename:String!
    var pdfFile:NSData!
    var invoiceDate:String!
    var firstDayOfCurrentMonth:String!
    var lastDayOfCurrentMonth:String!
    var brandWebedia:String!
    var liveWebedia:String!
    var wwwWebedia:String!
    var wwwUrl: URL!
    
    
    override init() {
        super.init()
        
    }
    
    
    func renderInvoice (firstDate:String, lastDate:String, brand:String, live:String, www:String) -> String! {
        
        self.firstDayOfCurrentMonth = firstDate
        self.lastDayOfCurrentMonth = lastDate
        self.brandWebedia = brand
        self.liveWebedia = live
        self.wwwWebedia = www
        
        do {
            var HTMLContent = try String(contentsOfFile: pathToInvoiceHTMLTemplate!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FIRSTDATE#", with: firstDayOfCurrentMonth)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LASTDATE#", with: lastDayOfCurrentMonth)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#BRANDFRARRAY#", with: brandWebedia)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LIVE#", with: liveWebedia)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#WWW#", with: wwwWebedia)
            
            
            
            // Conversion to string to URL
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
        
        
        
        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Potvrda \(month)/2019.pdf"
        
        
        pdfData!.write(toFile: pdfFilename, atomically: true)
        
        
    }
    
    
    
    
}
