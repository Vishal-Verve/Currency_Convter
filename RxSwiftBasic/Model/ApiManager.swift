//
//  ApiManager.swift
//  RxSwiftBasic
//
//  Created by Verve on 30/08/22.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: RequestObservable class
public class RequestObservable {
  private lazy var jsonDecoder = JSONDecoder()
  private var urlSession: URLSession
  public init(config: URLSessionConfiguration) {
      urlSession = URLSession(configuration:
                URLSessionConfiguration.default)
  }

// MARK: function for URLSession takes
  public func callAPI<T: Decodable>(request: URLRequest)
    -> Observable<T> {
  // MARK: creating our observable
  return Observable.create { observer in
  // MARK: create URLSession dataTask
  let task = self.urlSession.dataTask(with: request) { (data,
                response, error) in
  if let httpResponse = response as? HTTPURLResponse {
  let statusCode = httpResponse.statusCode
  do {
    let _data = data ?? Data()
    if (200...399).contains(statusCode) {
      let objs = try self.jsonDecoder.decode(T.self, from:
                          _data)
      // MARK: observer onNext event
      observer.onNext(objs)
    }

  } catch {
      // MARK: observer onNext event
      observer.onError(error)
     }
   }
     // MARK: observer onCompleted event
     observer.onCompleted()
   }
     task.resume()
     // MARK: return our disposable
     return Disposables.create {
       task.cancel()
     }
   }
  }

    public func callConverterAPI<T: Decodable>(request: URLRequest)
      -> Observable<T> {
    // MARK: creating our observable
    return Observable.create { observer in
    // MARK: create URLSession dataTask
    let task = self.urlSession.dataTask(with: request) { (data,
                  response, error) in
    if let httpResponse = response as? HTTPURLResponse {
    let statusCode = httpResponse.statusCode
    do {
      let _data = data ?? Data()
      if (200...399).contains(statusCode) {
        let objs = try self.jsonDecoder.decode(T.self, from:
                            _data)
        // MARK: observer onNext event
        observer.onNext(objs)
      } else {
        observer.onError(error!)
      }
    } catch {
        // MARK: observer onNext event
        observer.onError(error)
       }
     }
       // MARK: observer onCompleted event
       observer.onCompleted()
     }
       task.resume()
       // MARK: return our disposable
       return Disposables.create {
         task.cancel()
       }
     }
    }

}
