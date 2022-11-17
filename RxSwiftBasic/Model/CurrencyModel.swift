//
//  CurrencyModel.swift
//  RxSwiftBasic
//
//  Created by Verve on 29/08/22.
//

import Foundation
import RxSwift
import RxRelay

struct ModelSymbolCurrency: Codable {

    let success: Bool?
    let symbols: [String: String]?
    private enum CodingKeys: String, CodingKey {
        case success
        case symbols
    }

}

struct ModelPopularCurrency: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

struct ModelCurrencyConverter: Codable {
        let success: Bool
        let query: Query
        let info: Info
        let date: String
        let result: Double
    }

    // MARK: - Info
    struct Info: Codable {
        let timestamp: Int
        let rate: Double
    }

    // MARK: - Query
    struct Query: Codable {
        let from, to: String
        let amount: Int
    }

public enum RequestType: String {
    case GET, POST, PUT, DELETE
}
