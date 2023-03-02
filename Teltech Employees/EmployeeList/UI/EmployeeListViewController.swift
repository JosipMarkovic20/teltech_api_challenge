//
//  EmployeeListViewController.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

final class EmployeeListViewController: UIViewController {
    
    private let viewModel: EmployeeListViewModel
    
    init(viewModel: EmployeeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
