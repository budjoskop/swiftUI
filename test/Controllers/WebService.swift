//
//  WebService.swift
//  test
//
//  Created by ognjen on 15/08/2019.
//  Copyright © 2019 ognjen. All rights reserved.
//

import Foundation
import SwiftUI
import Combine




class WebService: ObservableObject {
    
    let didChange = PassthroughSubject<WebService, Never>()
    
    @Published var eurValue = String() {
        didSet {
            didChange.send(self)
            print(self.eurValue)
        }
    }
    
    
    
    init() {
        
        let jsonUrlString = "https://api.kursna-lista.info/8e3a2d6a8146012d36aa40c2b23928b2/kursna_lista"
        guard  let url = URL(string: jsonUrlString) else {fatalError("URL is not correct")}
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let fetchedEurValue = try! JSONDecoder().decode(Currency.self, from: data!)
            DispatchQueue.main.async {
                self.eurValue = (fetchedEurValue.result.eur.sre)
            }
            
        }.resume()
    }
}

