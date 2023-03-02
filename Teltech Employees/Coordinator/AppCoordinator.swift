//
//  AppCoordinator.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

class AppCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    func start() {
        let presenter = UINavigationController()
        window.rootViewController = presenter
        window.makeKeyAndVisible()
        createEmployeeListCoordinator(presenter: presenter)
    }
    private func createEmployeeListCoordinator(presenter: UINavigationController){
        let employeeListCoordinator = EmployeeListCoordinator(navController: presenter)
        self.addChildCoordinator(coordinator: employeeListCoordinator)
        employeeListCoordinator.start()
    }
}

extension AppCoordinator: CoordinatorDelegate{
    func viewControllerHasFinished() {
        childCoordinators.removeAll()
        removeChildCoordinator(coordinator: self)
    }
}
