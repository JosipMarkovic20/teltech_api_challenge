//
//  EmployeeItem.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import RxDataSources

final class EmployeeItem: IdentifiableType, Equatable{
    
    public let identity: String
    let item: EmployeeViewItem
    
    init(identity: String, item: EmployeeViewItem){
        self.item = item
        self.identity = identity
    }
    
    static func ==(lhs: EmployeeItem, rhs: EmployeeItem) -> Bool {
        lhs.identity == rhs.identity
    }
}

struct EmployeeViewItem: Equatable {
    
    let name: String
    let surname: String
    let image: String
    let title: String
    let agency: String
    let intro: String
    let description: String
    
    static func == (lhs: EmployeeViewItem, rhs: EmployeeViewItem) -> Bool {
        lhs.name == rhs.name && lhs.surname == rhs.surname && lhs.intro == rhs.intro
    }
}
