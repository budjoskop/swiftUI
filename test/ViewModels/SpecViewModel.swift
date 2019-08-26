
//  SpecWorkController.swift
//  test
//
//  Created by ognjen on 23/08/2019.
//  Copyright © 2019 ognjen. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import WebKit


struct SpecWorkModel: UIViewRepresentable {
    
    //    @ObservedObject var model = WebService()
    let webView = WKWebView() //Create WKWebView
    let url = Bundle.main.url(forResource: "potvrda", withExtension: "html")! // Create local html
    let date = Date ()
    let brandArr:[String] = ["Villa Schweppes", "Franprix", "Beaute","Tic Tac", "Ribambel", "Arkea", "EDF", "ESONE", "Franck Provost", "FCD", "Jean Louis David", "Orange", "Hello Life"]
    var brandFr = ""
    let wwwWebedia = "PurePeople, PureBreak, TeraFemina"
    let liveWebedia = "La Seine Musicale, Château de Versailles, La Villette"
    
    func createNewString () -> String {
        
        let newBrandString:String!
        
        var newBrandArray:[String] = []
        
        newBrandArray = brandArr.shuffled()
        let newBrandArrayShort = newBrandArray[0...5]
        
        newBrandString = newBrandArrayShort.joined(separator:",")
        
        return newBrandString
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        var HTMLContent: String!
        let invoiceComposer = SpecModel()
        let first = date.firstAndLastDate().2
        let last = date.firstAndLastDate().3
        
        
        
        DispatchQueue.main.async {
            
            if let invoiceHTML = invoiceComposer.renderInvoice(firstDate: first, lastDate: last, brand: self.brandFr, live: self.liveWebedia, www: self.wwwWebedia ) {
                HTMLContent = invoiceHTML
                uiView.loadHTMLString(HTMLContent, baseURL: nil)
                
            }
        }
        
        //        let request = URLRequest(url: url) // Create request with local url
        //        webView.loadFileURL(url, allowingReadAccessTo: url)
        //        uiView.load(request)
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<SpecWorkModel>) -> WKWebView {
        
        return WKWebView()
        
    }
    
    
}
