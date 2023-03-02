//
//  Team.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation

struct Team: Equatable, Codable {
    let teamTitle: String
    let employees: [Employee]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        let dict = try container.decode([String:[Employee]].self)
        
        guard let key = dict.keys.first else {
            throw EmployeeError.general
        }
        
        self.teamTitle = key
        self.employees = dict[key] ?? []
    }
}
