//
//  EurViewModel.swift
//  test
//
//  Created by ognjen on 15/08/2019.
//  Copyright © 2019 ognjen. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class EurViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<Void, Never>()
    
    //    var fetchedEurValue = Currency() {didSet {didChange.send()}}
    var eurValue = "Eur value" {didSet {didChange.send()}}
    
    
    init() {
        fetchPosts()
        print(self.eurValue)
    }
    
    private func fetchPosts ()  {
        WebService().fetchData {
            self.eurValue = ($0.result?.eur?.sre!)!
            
            
        }
    }
    
}
