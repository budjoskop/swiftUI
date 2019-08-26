import Foundation
import SwiftUI

struct Currency: Decodable {
    
    let result: Results
}


struct Results: Decodable {
    
    
    let date: String
    let eur: Eur
}


struct Eur: Decodable {

   var sre: String
 
}
