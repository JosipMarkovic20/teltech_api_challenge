//
//  UIViewController+Extension.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertWith(title: String?,
                       message: String?,
                       action: UIAlertAction,
                       anotherAction: UIAlertAction? = nil){
        
        let alert: UIAlertController = {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(action)
            if anotherAction != nil {
                alert.addAction(anotherAction!)
            }
            return alert
        }()
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
