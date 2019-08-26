//
//  InvoiceView.swift
//  test
//
//  Created by ognjen on 21/08/2019.
//  Copyright © 2019 ognjen. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import WebKit


struct InvoiceViewModel: UIViewRepresentable {
    
    @ObservedObject var model = WebService()
    let webView = WKWebView() //Create WKWebView
    let url = Bundle.main.url(forResource: "invoiceTemplate", withExtension: "html")! // Create local html
    let date = Date ()
    func updateUIView(_ uiView: WKWebView, context: Context) {
        var HTMLContent: String!
        let invoiceComposer = InvoiceComposserModel()
        let dateForInvoice = date.firstAndLastDate().0
        let invoiceNumber = date.firstAndLastDate().1
        let first = date.firstAndLastDate().2
        let last = date.firstAndLastDate().3
        let todayDate = date.firstAndLastDate().4
        
        
        DispatchQueue.main.async {
            guard let sallaryEurValue = Double(self.model.eurValue) else {return}
            let rsdSalaray = 1700.00 * round(Double(sallaryEurValue) * 10000.00)/10000.00
            if let invoiceHTML = invoiceComposer.renderInvoice(cena: String(rsdSalaray), eurValue: self.model.eurValue, invoice: todayDate, firstDate: first, lastDate: last, invoiceNumberOnDocument: invoiceNumber, lastDatePayoff: dateForInvoice) {
                HTMLContent = invoiceHTML
                uiView.loadHTMLString(HTMLContent, baseURL: nil)
                
            }
        }
        
        //        let request = URLRequest(url: url) // Create request with local url
        //        webView.loadFileURL(url, allowingReadAccessTo: url)
        //        uiView.load(request)
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<InvoiceViewModel>) -> WKWebView {
        
        return WKWebView()
        
    }
    
    
}
