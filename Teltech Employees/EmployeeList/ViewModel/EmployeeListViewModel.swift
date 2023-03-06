//
//  EmployeeListViewModel.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import RxSwift
import RxCocoa

protocol EmployeeListViewModel {
    func bindViewModel() -> [Disposable]
    var loaderPublisher: PublishSubject<Bool> {get}
    var input: ReplaySubject<EmployeeListInput> {get}
    var output: BehaviorRelay<EmployeeListOutput> {get}
}

final class EmployeeListViewModelImpl: EmployeeListViewModel {
    
    struct Dependecies {
        let employeesRepository: EmployeesRepository
    }
    
    var loaderPublisher = PublishSubject<Bool>()
    var input: ReplaySubject<EmployeeListInput> = ReplaySubject.create(bufferSize: 1)
    var output: BehaviorRelay<EmployeeListOutput> = BehaviorRelay(value: EmployeeListOutput(items: []))
    let dependecies: Dependecies
    
    init(dependecies: Dependecies) {
        self.dependecies = dependecies
    }
}

extension EmployeeListViewModelImpl {
    
    func bindViewModel() -> [Disposable] {
        
        var disposables = [Disposable]()
        disposables.append(self.input
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap({[weak self] input -> Observable<EmployeeListOutput> in
                
                guard let self = self else {
                    return .just(EmployeeListOutput(items: []))
                }
                
                switch input {
                case .loadData, .pullToRefresh:
                    return self.handleDataLoading()
                case .employeeTapped(indexPath: let indexPath):
                    return self.handleEmployeeTap(indexPath: indexPath)
                }
            }).bind(to: output))
        
        return disposables
    }
    
    private func handleDataLoading() -> Observable<EmployeeListOutput> {
        
        self.loaderPublisher.onNext(true)
        
        return dependecies.employeesRepository.getAllEmployees()
            .flatMap {[weak self] result -> Observable<EmployeeListOutput> in
               
                guard let self = self else {
                    return .just(EmployeeListOutput(items: []))
                }
                
                self.loaderPublisher.onNext(false)
                
                switch result {
                case .success(let teamList):
                    let items = self.createScreenData(from: teamList)
                    return .just(EmployeeListOutput(items: items, event: .reloadData))
                case .failure(let error):
                    return .just(EmployeeListOutput(items: self.output.value.items, event: .error(error.localizedDescription)))
                }
        }
    }
    
    private func handleEmployeeTap(indexPath: IndexPath) -> Observable<EmployeeListOutput> {
        let item = output.value.items[indexPath.section].items[indexPath.row]
        return .just(EmployeeListOutput(items: output.value.items, event: .openDetails(employeeItem: item.item)))
    }
    
    private func createScreenData(from teamList: TeamList) -> [EmployeeListSectionItem] {
        return teamList.teams.map { team -> EmployeeListSectionItem in
            return EmployeeListSectionItem(identity: team.teamTitle, items: team.employees.map({ employee -> EmployeeItem in
                return EmployeeItem(identity: employee.name+employee.surname+employee.intro, item: EmployeeViewItem(name: employee.name, surname: employee.surname, image: employee.image, title: employee.title, agency: employee.agency, intro: employee.intro, description: employee.description, teamTitle: team.teamTitle))
            }))
        }
    }
}
