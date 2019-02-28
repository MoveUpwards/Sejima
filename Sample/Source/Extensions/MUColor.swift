//
//  MUColor.swift
//  MUSample
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     Create a UIColor from hexadecimal value

     - Parameters:
     - hex: The hexadecimal value.

     ```
     let darkGrey = UIColor(hex: 0x757575)
     ```
     */
    convenience public init(hex: Int, alpha: Int = 0xff) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / 255.0,
                  green: CGFloat((hex >> 8) & 0xff) / 255.0,
                  blue: CGFloat(hex & 0xff) / 255.0,
                  alpha: CGFloat(alpha & 0xff) / 255.0)
    }
}
