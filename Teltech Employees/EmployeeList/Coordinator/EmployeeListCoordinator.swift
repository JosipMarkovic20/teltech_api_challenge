//
//  EmployeeListCoordinator.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

final class EmployeeListCoordinator: NSObject, Coordinator {
    
    let navigationController: UINavigationController
    let employeeListViewController: EmployeeListViewController
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
        navigationController.pushViewController(employeeListViewController, animated: true)
    }

    static private func createEmployeeListViewController() -> EmployeeListViewController {
        let viewModel = EmployeeListViewModelImpl()
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
