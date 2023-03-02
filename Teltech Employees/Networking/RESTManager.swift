//
//  RESTManager.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import RxSwift
import Alamofire

final class RESTManager {
        
    func requestObservable<T: Codable>(url: String) -> Observable<T> {
        
        return Observable.create{ observer in
            
            let request = AF.request(url, parameters: nil).validate().responseDecodable(of: T.self,
                                                                                        decoder: JSONDecoder()){ networkResponse in
                switch networkResponse.result{
                case .success:
                    do{
                        let response = try networkResponse.result.get()
                        observer.onNext(response)
                        observer.onCompleted()
                    }
                    catch(let error){
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
