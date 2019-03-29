//
//  MUQuad.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 04/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//
//  https://en.wikipedia.org/wiki/Quadrilateral
//

import UIKit

/// A Quadrilateral
public struct MUQuad {
    /// Top left corner position.
    public var topLeft: CGPoint
    /// Top right corner position.
    public var topRight: CGPoint
    /// Bottom left corner position.
    public var bottomLeft: CGPoint
    /// Bottom right corner position.
    public var bottomRight: CGPoint

    /// Init a quad from corners.
    public init(topLeft: CGPoint, topRight: CGPoint, bottomLeft: CGPoint, bottomRight: CGPoint) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }

    /// Init a quad from a rectangle.
    public init(rect: CGRect) {
        topLeft = CGPoint(x: rect.minX, y: rect.minY)
        topRight = CGPoint(x: rect.maxX, y: rect.minY)
        bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
    }

    /// The bounds rectangle, which the quad fit inside.
    public var boundingBox: CGRect {
        let xMin = min(topRight.x, topLeft.x, bottomLeft.x, bottomRight.x)
        let yMin = min(topRight.y, topLeft.y, bottomLeft.y, bottomRight.y)
        let xMax = max(topRight.x, topLeft.x, bottomLeft.x, bottomRight.x)
        let yMax = max(topRight.y, topLeft.y, bottomLeft.y, bottomRight.y)

        return CGRect(x: xMin, y: yMin, width: xMax - xMin, height: yMax - yMin)
    }

    /// Get corners from index, clockwise starting from topLeft corner.
    public func point(_ index: Int) -> CGPoint {
        switch index {
        case 0:
            return topLeft
        case 1:
            return topRight
        case 2:
            return bottomRight
        case 3:
            return bottomLeft
        default:
            // Should assert Out of bounds
            return .zero
        }
    }

    /// + operator for Quad and Point
    public static func + (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x + rhs.x, y: lhs.topLeft.y + rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x + rhs.x, y: lhs.topRight.y + rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x + rhs.x, y: lhs.bottomLeft.y + rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x + rhs.x, y: lhs.bottomRight.y + rhs.y))
    }

    /// - operator for Quad and Point
    public static func - (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x - rhs.x, y: lhs.topLeft.y - rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x - rhs.x, y: lhs.topRight.y - rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x - rhs.x, y: lhs.bottomLeft.y - rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x - rhs.x, y: lhs.bottomRight.y - rhs.y))
    }

    /// * operator for Quad and Point
    public static func * (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x * rhs.x, y: lhs.topLeft.y * rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x * rhs.x, y: lhs.topRight.y * rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x * rhs.x, y: lhs.bottomLeft.y * rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x * rhs.x, y: lhs.bottomRight.y * rhs.y))
    }

    /// / operator for Quad and Point
    public static func / (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x / rhs.x, y: lhs.topLeft.y / rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x / rhs.x, y: lhs.topRight.y / rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x / rhs.x, y: lhs.bottomLeft.y / rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x / rhs.x, y: lhs.bottomRight.y / rhs.y))
    }
}
