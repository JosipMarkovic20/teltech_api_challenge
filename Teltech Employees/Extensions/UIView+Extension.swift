//
//  UIView+Extension.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(views: [UIView]){
        for view in views{
            self.addSubview(view)
        }
    }
    
    func roundCorners(_ corners: CACornerMask = [.layerMinXMinYCorner,
                                                 .layerMaxXMinYCorner,
                                                 .layerMinXMaxYCorner,
                                                 .layerMaxXMaxYCorner],
                      radius: CGFloat) {

        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.cornerCurve = .continuous
    }
}
