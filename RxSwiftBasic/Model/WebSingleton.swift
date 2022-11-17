//
//  WebSingleton.swift
//  RxSwiftBasic
//
//  Created by Verve on 30/08/22.
//

import Foundation
import RxCocoa
import RxSwift
// MARK: extension for converting out RecipeModel to jsonObject

class APIClient {
    static var shared = APIClient()
    var components = URLComponents()
    let SharedDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var strApiKey: String = "e2XHupmm2ZhwCTDgCGVs2PTayHf0eqrW"
    lazy var requestObservable = RequestObservable(config: .default)
    func callCommonRequestStruct(passEndPoint: String) -> URLRequest {
        var requestURL = URLRequest(url: URL(string: "\(ApiEndPoint.URL.Host)\(passEndPoint)")!)
        requestURL.httpMethod = "GET"
        requestURL.addValue("application/json", forHTTPHeaderField:
                                "Content-Type")
        requestURL.addValue(APIClient.shared.strApiKey, forHTTPHeaderField: "apikey")
        
        return requestURL
    }
    
    func callSymbolList(passEndPoint: String) throws -> Observable<ModelSymbolCurrency> {
        let request =   callCommonRequestStruct(passEndPoint: ApiEndPoint.SymbolGet.getSymbolCurrency)
        return requestObservable.callAPI(request: request)
    }
    
    func callConverterListApi(passParam: [String: String], passEndPoint: String) throws -> Observable<ModelCurrencyConverter> {
        components.host = "api.apilayer.com"
        components.scheme = "https"
        components.path = "/fixer/\(passEndPoint)"
        if !passParam.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in passParam {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue(APIClient.shared.strApiKey, forHTTPHeaderField: "apikey")
        return requestObservable.callConverterAPI(request: request)
    }
    
    func callgetPopularCurrencyApi(passParam: [String: String]) throws -> Observable<ModelPopularCurrency> {
        components.host = "api.apilayer.com"
        components.scheme = "https"
        components.path = "/fixer/\(ApiEndPoint.PopularCurrency.getPopularCurrency)"
        if !passParam.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in passParam {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue(APIClient.shared.strApiKey, forHTTPHeaderField: "apikey")
        return requestObservable.callConverterAPI(request: request)
    }
    
}
