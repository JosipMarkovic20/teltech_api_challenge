//
//  EmployeeListOutput.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import RxDataSources
import RxCocoa

struct EmployeeListOutput{
    var items: [EmployeeListSectionItem]
    var event: EmployeeListOutputEvent?
}

enum EmployeeListOutputEvent{
    case reloadData
    case error(_ message: String)
    case openDetails(activity: EmployeeViewItem)
}

struct EmployeeListSectionItem: Equatable{
    var identity: String
    var items: [Item]
    
    static func ==(lhs: EmployeeListSectionItem, rhs: EmployeeListSectionItem) -> Bool {
        return lhs.identity == rhs.identity
    }

    init(identity: String, items: [Item]){
        self.identity = identity
        self.items = items
    }
}

extension EmployeeListSectionItem: AnimatableSectionModelType{
    typealias Item = EmployeeItem
    
    init(original: EmployeeListSectionItem, items: [Item]) {
        self = original
        self.items = items
    }
}
