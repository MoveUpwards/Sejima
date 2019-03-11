//
//  MUMath.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 08/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import Foundation

extension FloatingPoint {
    /// Convert current degrees to radians
    public var toRadians: Self {
        return .pi * self / Self(180)
    }

    /// Convert current radians to degrees
    public var toDegrees: Self {
        return self * Self(180) / .pi
    }
}
