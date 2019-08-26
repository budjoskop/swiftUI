//
//  ContentView.swift
//  test
//
//  Created by ognjen on 13/08/2019.
//  Copyright © 2019 ognjen. All rights reserved.
//

import SwiftUI
import Combine



struct ContentView: View {
    
    @ObservedObject var model = WebService()
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                VStack (alignment: .leading, spacing: 10){
                    Text("Today's eur value is:")
                        .font(.headline)
                    
                    Text("\(model.eurValue)")
                        
                        .padding(.bottom, 200)
                    
                }
                .padding(.trailing, 150)
                
                
                
                NavigationLink(destination: InvoiceView()) {
                    Text("Show Invoice View")
                }
                
            }
            .navigationBarTitle("ConsoleWork")
            
            
            
            
        }
        
    }
}









#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
