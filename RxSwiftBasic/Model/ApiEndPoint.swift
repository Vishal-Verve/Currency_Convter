//
//  ApiEndPoint.swift
//  RxSwiftBasic
//
//  Created by Verve on 30/08/22.
//

import Foundation
import UIKit

class ApiEndPoint: NSObject {

    struct URL {
        static let Host = "https://api.apilayer.com/fixer/"
    }
    struct PopularCurrency {
        static let getPopularCurrency = "latest"
    }
    struct SymbolGet {
        static let getSymbolCurrency = "symbols"
    }
    struct AmountConverter {
        static let currencyConverter = "convert"
    }
}
