//
//  DetailsOutput.swift
//  Teltech Employees
//
//  Created by Josip Marković on 06.03.2023..
//

import Foundation

struct DetailsOutput{
    var item: EmployeeViewItem?
    var event: DetailsOutputEvent?
}

enum DetailsOutputEvent{
    case reloadData
    case error(_ message: String)
}
