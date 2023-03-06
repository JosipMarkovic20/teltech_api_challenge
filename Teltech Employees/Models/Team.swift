//
//  Team.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation

struct TeamList: Equatable, Decodable {
    let teams: [Team]
    
    struct CodingKeys: CodingKey, Hashable {
        
        var stringValue: String
        
        init(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? {
            return nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teamTitles = container.allKeys
        
        var teams = [Team]()
        
        for teamTitle in teamTitles {
            let employees = try container.decode([Employee].self, forKey: teamTitle)
            let team = Team(teamTitle: teamTitle.stringValue, employees: employees)
            teams.append(team)
        }
        self.teams = teams
    }
}

struct Team: Equatable {
    let teamTitle: String
    let employees: [Employee]
}
