//
//  DetailsViewModel.swift
//  Teltech Employees
//
//  Created by Josip Marković on 06.03.2023..
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailsViewModel {
    func bindViewModel() -> [Disposable]
    var input: ReplaySubject<DetailsInput> {get}
    var output: BehaviorRelay<DetailsOutput> {get}
}

final class DetailsViewModelImpl: DetailsViewModel {
    
    struct Dependencies {
        let employee: EmployeeViewItem
    }
    
    var input: ReplaySubject<DetailsInput> = ReplaySubject.create(bufferSize: 1)
    var output: BehaviorRelay<DetailsOutput> = BehaviorRelay.init(value: DetailsOutput(item: nil, event: nil))
    var dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension DetailsViewModelImpl {
    
    func bindViewModel() -> [Disposable] {
        var disposables = [Disposable]()
        disposables.append(self.input
                            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                            .flatMap{ [unowned self] (input) -> Observable<DetailsOutput> in
                                switch input{
                                case .loadData:
                                    return .just(.init(item: dependencies.employee, event: .reloadData))
                                }
                            }.bind(to: output))
        return disposables
    }
}
