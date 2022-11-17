//
//  CommonApiCall.swift
//  RxSwiftBasic
//
//  Created by Verve on 02/09/22.
//

import Foundation
import UIKit
import SVProgressHUD
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// MARK: Api Calling
class CommonApi {
    
    class func callSymbolListApi(completion: @escaping  (Bool) -> Void) {
        Utils.showProgressHud()
        let client = APIClient.shared
        do {
            try client.callSymbolList(passEndPoint: ApiEndPoint.SymbolGet.getSymbolCurrency).subscribe(
                onNext: { result in
                    DispatchQueue.main.async {
                        APIClient.shared.SharedDelegate.arrSymbol =  result.symbols!
                        Utils.hideProgressHud()
                        
                    }
                    completion(true)
                },
                onError: { error in
                    DispatchQueue.main.async {
                        Utils.hideProgressHud()
                    }
                    completion(false)
                    print(error.localizedDescription)
                },
                onCompleted: {
                    DispatchQueue.main.async {
                        Utils.hideProgressHud()
                    }
                    completion(true)
                    print("Completed event.")
                }).disposed(by: disposeBag)
        } catch {
        }
    }
    
    //    class func getApi(passapiEndPoint:String,passapiUrl:String,passParameter:[String:String]) -> Observable<AnyObject?> {
    //        return Observable.create{ observer in
    //            var request1 = URLRequest(url: URL(string: passapiUrl)!)
    //            request1.httpMethod = HTTPMethod.get.rawValue
    //            request1.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //            request1.setValue("QXLily7Ptl3Hz4e3PsC1XtXtntk7LC93", forHTTPHeaderField: "apiKey")
    //
    //            AF.request(request1).responseJSON{(response) in
    //
    //            }
    //       }
    //   }
    
}
