//
//  Observable+Extension.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import RxSwift

extension Observable {
    func handleError() -> Observable<Result<Element, Error>> {
        return self.map { (element) -> Result<Element, Error> in
            return .success(element)
        }.catch { error -> Observable<Result<Element, Error>> in
            return .just(.failure(error))
        }
    }
}
