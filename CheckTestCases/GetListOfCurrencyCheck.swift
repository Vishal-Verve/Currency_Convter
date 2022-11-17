//
//  GetListOfCurrencyCheck.swift
//  CheckTestCases
//
//  Created by Verve on 01/09/22.
//

import XCTest

@testable import RxSwift
@testable import RxCocoa
@testable import RxSwiftBasic

class GetListOfCurrencyCheck: XCTestCase {
    let urlSession = URLSession.shared
    private lazy var jsonDecoder = JSONDecoder()
    lazy var requestObservable = RequestObservable(config: .default)
    static let getSymbolCurrency = "symbols"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testcheckCurrencySymbol() throws {

        var request = URLRequest(url: URL(string: "https://api.apilayer.com/fixer/symbol")!)
        request.httpMethod = "GET"
          request.addValue("application/json", forHTTPHeaderField:
                    "Content-Type")
          request.addValue(APIClient.shared.strApiKey, forHTTPHeaderField: "apikey")
          callAPI(request: request)
    }

    func callAPI(request: URLRequest) {
    // MARK: create URLSession dataTask
          let task = self.urlSession.dataTask(with: request) { (_,
                        response, _) in
          if let httpResponse = response as? HTTPURLResponse {
          let statusCode = httpResponse.statusCode
          do {
            // let _data = data ?? Data()
            if (200...399).contains(statusCode) {
                // let objs = try self.jsonDecoder.decode(getSymbolCurrency.self, from:
                // _data)
                XCTAssert(true, "The Obj get Responses")
              // MARK: observer onNext event
            } else {
                XCTAssert(false, "The Obj get Not response")
            }
          }
           }
             // MARK: observer onCompleted event
           }
             task.resume()
      }

}

struct modelSymbolCurrency: Codable {

    let success: Bool?
    let symbols: [String: String]?
    private enum CodingKeys: String, CodingKey {
        case success
        case symbols
    }

}
