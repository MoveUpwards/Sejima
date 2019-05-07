//
//  MUMath.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 08/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

/// FloatingPoint protocol
public protocol MUFloatingPoint: FloatingPoint {
    /// A very close to 0 number
    static var epsilon: Self { get }

    /// The hypotenuse of given numbers
    static func hypotenuse(_ lhs: Self, _ rhs: Self) -> Self

    /// Return a floating point from a given double
    init(_ double: Double)
}

extension FloatingPoint {
    /// Convert current degrees to radians
    internal var toRadians: Self {
        return .pi * self / Self(180)
    }

    /// Convert current radians to degrees
    internal var toDegrees: Self {
        return self * Self(180) / .pi
    }
}

extension CGFloat: MUFloatingPoint {
    /// A very close to 0 number
    public static let epsilon: CGFloat = 8.85418782e-12

    /// The hypotenuse of given numbers
    public static func hypotenuse(_ lhs: CGFloat, _ rhs: CGFloat) -> CGFloat {
        return hypot(lhs, rhs)
    }
}

extension Double: MUFloatingPoint {
    /// A very close to 0 number
    public static let epsilon: Double = 8.85418782e-12

    /// The hypotenuse of given numbers
    public static func hypotenuse(_ lhs: Double, _ rhs: Double) -> Double {
        return hypot(lhs, rhs)
    }
}

extension Float: MUFloatingPoint {
    /// A very close to 0 number
    public static let epsilon: Float = 8.85418782e-12

    /// The hypotenuse of given numbers
    public static func hypotenuse(_ lhs: Float, _ rhs: Float) -> Float {
        return hypot(lhs, rhs)
    }
}

#if !os(Windows) && (arch(i386) || arch(x86_64))
extension Float80: MUFloatingPoint {
    /// A very close to 0 number
    public static let epsilon: Float80 = 8.85418782e-12

    /// The hypotenuse of given numbers
    public static func hypotenuse(_ lhs: Float80, _ rhs: Float80) -> Float80 {
        return hypot(lhs, rhs)
    }
}
#endif
