//
//  Employee.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation

struct Employee: Codable, Equatable {
    let name: String
    let surname: String
    #warning("check why is url missing in response for image")
    let image: String
    let title: String
    let agency: String
    let intro: String
    let description: String
}
