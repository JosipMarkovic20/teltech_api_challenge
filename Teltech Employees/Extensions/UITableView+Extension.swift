//
//  UITableView+Extension.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

extension UITableView{
    func dequeueCell<T: UITableViewCell>(identifier: String) -> T{
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? T else{return T()}
        return cell
    }
}
