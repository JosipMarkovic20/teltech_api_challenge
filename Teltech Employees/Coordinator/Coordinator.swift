//
//  Coordinator.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

protocol Coordinator: AnyObject{
    var childCoordinators: [Coordinator] {get set}
    
    func start()
}

extension Coordinator{
    func addChildCoordinator(coordinator: Coordinator){
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(coordinator: Coordinator){
        childCoordinators = childCoordinators.filter{ $0 !== coordinator}
    }
}
