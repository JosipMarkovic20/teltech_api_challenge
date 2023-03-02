//
//  EmployeesRepository.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import RxSwift

final class EmployeesRepositoryImpl: EmployeesRepository {
    
    private let manager = RESTManager()
    
    func getAllEmployees() -> Observable<Result<Team, Error>> {
        
        let observable: Observable<Result<Team, Error>> = manager.requestObservable(url: RESTEndpoints.employees.endpoint()).handleError()
        return observable
    }
}
protocol EmployeesRepository {
    func getAllEmployees() -> Observable<Result<Team, Error>>
}
