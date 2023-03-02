//
//  EmployeeListInput.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation

enum EmployeeListInput{
    case loadData
    case employeeTapped(indexPath: IndexPath)
    case pullToRefresh
}
