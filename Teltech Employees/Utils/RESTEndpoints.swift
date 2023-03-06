//
//  RESTEndpoints.swift
//  Teltech Employees
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation

enum RESTEndpoints{
    
    //RETURN VALUES ARE COMMENTED OUT UNTIL API IS PROVIDED
    static var scheme: String{
        return ""
//      return Bundle.main.infoDictionary!["API_BASE_SCHEME"] as! String
    }
    
    static var host: String{
        return ""
//        Bundle.main.infoDictionary!["API_BASE_HOST"] as! String
    }
    
    static var path: String{
        return ""
//        Bundle.main.infoDictionary!["API_BASE_PATH"] as! String
    }
    
    public static var ENDPOINT: String {
        return scheme + host + path
    }

    case employees
    
    func endpoint() -> String {
        
        switch self {
        case .employees:
            return RESTEndpoints.ENDPOINT + "employees"
        }
    }
}
