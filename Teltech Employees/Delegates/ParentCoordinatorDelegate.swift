//
//  ParentCoordinatorDelegate.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation

protocol ParentCoordinatorDelegate: AnyObject {
    func childHasFinished(coordinator: Coordinator)
}
