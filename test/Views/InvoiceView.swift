//
//  InvoiceView.swift
//  test
//
//  Created by ognjen on 23/08/2019.
//  Copyright © 2019 ognjen. All rights reserved.
//

import SwiftUI
import WebKit
import Combine

struct InvoiceView: View {
    @ObservedObject var model = WebService()

    var body: some View {
        VStack{
            
            InvoiceViewModel()
            

        }.navigationBarTitle("ConsoleWork Invoice")
    }
}

#if DEBUG
struct InvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceView()
    }
}
#endif
