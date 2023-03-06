//
//  DetailsCoordinator.swift
//  Teltech Employees
//
//  Created by Josip Marković on 06.03.2023..
//

import Foundation
import UIKit

final class DetailsCoordinator: NSObject, Coordinator {
    private let navigationController: UINavigationController
    private let detailsViewController: DetailsViewController
    var childCoordinators: [Coordinator] = []
    weak var parentDelegate: ParentCoordinatorDelegate?
    
    init(navController: UINavigationController, employee: EmployeeViewItem) {
        navigationController = navController
        detailsViewController = DetailsCoordinator.createDetailsViewController(employee: employee)
        super.init()
    }
    
    deinit{
        print("Deinit: \(self)")
    }
    
    func start() {
        detailsViewController.coordinatorDelegate = self
        navigationController.pushViewController(detailsViewController, animated: true)
    }

    private static func createDetailsViewController(employee: EmployeeViewItem) -> DetailsViewController {
        let viewModel = DetailsViewModelImpl(dependencies: DetailsViewModelImpl.Dependencies(employee: employee))
        let viewController = DetailsViewController(viewModel: viewModel)
        return viewController
    }
}
extension DetailsCoordinator: CoordinatorDelegate, ParentCoordinatorDelegate{
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        parentDelegate?.childHasFinished(coordinator: self)
    }
    
    func childHasFinished(coordinator: Coordinator) {
        removeChildCoordinator(coordinator: coordinator)
    }
}
