//
//  MUColor.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 18/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit.UIColor

extension UIColor {

    /// Return the red component of the UIColor
    internal var r: CGFloat {
        return cgColor.components?[0] ?? 0.0
    }

    /// Return the green component of the UIColor
    internal var g: CGFloat {
        return cgColor.components?[cgColor.numberOfComponents == 2 ? 0 : 1] ?? 0.0
    }

    /// Return the blue component of the UIColor
    internal var b: CGFloat {
        return cgColor.components?[cgColor.numberOfComponents == 2 ? 0 : 2] ?? 0.0
    }

    /// Return the alpha component of the UIColor
    internal var a: CGFloat {
        return cgColor.components?[cgColor.numberOfComponents == 2 ? 1 : 3] ?? 0.0
    }

    /**
     Interpolate a fraction between the current color and a second one

     - Parameters:
     - to: The second color.
     - fraction: The percent of current color and second one.
     */
    internal func interpolate(to: UIColor, fraction: CGFloat) -> UIColor? {
        let f = min(max(0, fraction), 1) // Ensure that fraction is between 0 and 1
        return UIColor(red: r + (to.r - r) * f,
                       green: g + (to.g - g) * f,
                       blue: b + (to.b - b) * f,
                       alpha: a + (to.a - a) * f)
    }

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
