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
        
    func requestObservable<T: Decodable>(url: String) -> Observable<T> {
        
        return Observable.create{[weak self] observer in
            
            guard let self = self,
                  let localData = self.readLocalFile(forName: "teltechians") ,
                  let parsedData: T = self.parse(jsonData: localData) else {
                observer.onError(EmployeeError.general)
                observer.onCompleted()
                return Disposables.create()
            }
            
            observer.onNext(parsedData)
            observer.onCompleted()
            return Disposables.create()
            //COMMENTED OUT UNTIL I GET WORKING API
//            let request = AF.request(url, parameters: nil).validate().responseDecodable(of: T.self,
//                                                                                        decoder: JSONDecoder()){ networkResponse in
//                switch networkResponse.result{
//                case .success:
//                    do{
//                        let response = try networkResponse.result.get()
//                        observer.onNext(response)
//                        observer.onCompleted()
//                    }
//                    catch(let error){
//                        observer.onError(error)
//                    }
//                case .failure(let error):
//                    observer.onError(error)
//                }
//            }
//            return Disposables.create {
//                request.cancel()
//            }
        }
    }
    
    //TEMPORARY UNTIL I GET WORKING API
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse<T: Decodable>(jsonData: Data) -> T?{
        do {
            let decodedData = try JSONDecoder().decode(T.self,
                                                       from: jsonData)
            
            return decodedData
        } catch {
            return nil
        }
    }
}
