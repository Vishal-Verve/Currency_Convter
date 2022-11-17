//
//  CheckTestCases.swift
//  CheckTestCases
//
//  Created by Verve on 01/09/22.
//

import XCTest
@testable import RxSwiftBasic
@testable import RxSwift
@testable import RxCocoa

class CheckTestCases: XCTestCase {
    let urlSession = URLSession.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        _ = URLSession.shared

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.

    }

    func testcheckApiCall() throws {
        testcallConvertApi(passFromValue: "INR", passToValue: "USD", passAmount: "125")
    }

    func testcallConvertApi(passFromValue: String, passToValue: String, passAmount: String) {
        let url = URL(string: "https://api.apilayer.com/fixer/convert")!
        let finalURl = url.appending("to", value: passToValue).appending("from", value: passFromValue).appending("amount", value: passAmount)
        var request = URLRequest(url: finalURl)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:
                  "Content-Type")
        request.addValue(APIClient.shared.strApiKey, forHTTPHeaderField: "apikey")

        let task = self.urlSession.dataTask(with: request) { (_,
                      response, _) in
        if let httpResponse = response as? HTTPURLResponse {
        let statusCode = httpResponse.statusCode
        do {
          // let _data = data ?? Data()
          if (200...399).contains(statusCode) {
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
