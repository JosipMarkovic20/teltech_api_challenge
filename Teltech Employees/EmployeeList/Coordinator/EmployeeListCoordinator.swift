//
//  EmployeeListCoordinator.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

protocol EmployeeListNavigationDelegate: AnyObject {
    func navigateToEmployeeDetails(employee: EmployeeViewItem)
}

final class EmployeeListCoordinator: NSObject, Coordinator {
    
    private let navigationController: UINavigationController
    private let employeeListViewController: EmployeeListViewController
    var childCoordinators: [Coordinator] = []
    weak var parentDelegate: ParentCoordinatorDelegate?
    
    init(navController: UINavigationController) {
        navigationController = navController
        employeeListViewController = EmployeeListCoordinator.createEmployeeListViewController()
        super.init()
    }
    
    deinit{
        print("Deinit: \(self)")
    }
    
    func start() {
        employeeListViewController.employeeListNavigationDelegate = self
        navigationController.pushViewController(employeeListViewController, animated: true)
    }

    static private func createEmployeeListViewController() -> EmployeeListViewController {
        
        let dependecies = EmployeeListViewModelImpl.Dependecies(employeesRepository: EmployeesRepositoryImpl())
        let viewModel = EmployeeListViewModelImpl(dependecies: dependecies)
        let viewController = EmployeeListViewController(viewModel: viewModel)
        return viewController
    }
}
extension EmployeeListCoordinator: CoordinatorDelegate, ParentCoordinatorDelegate{
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        parentDelegate?.childHasFinished(coordinator: self)
    }
    
    func childHasFinished(coordinator: Coordinator) {
        removeChildCoordinator(coordinator: coordinator)
    }
}

extension EmployeeListCoordinator: EmployeeListNavigationDelegate {
    func navigateToEmployeeDetails(employee: EmployeeViewItem) {
        let coordinator = DetailsCoordinator(navController: navigationController, employee: employee)
        addChildCoordinator(coordinator: coordinator)
        coordinator.parentDelegate = self
        coordinator.start()
    }
}
