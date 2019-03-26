//
//  MUQuad.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 04/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

// https://en.wikipedia.org/wiki/Quadrilateral
public struct MUQuad {
    public var topLeft: CGPoint
    public var topRight: CGPoint
    public var bottomLeft: CGPoint
    public var bottomRight: CGPoint

    public init(topLeft: CGPoint, topRight: CGPoint, bottomLeft: CGPoint, bottomRight: CGPoint) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }

    public init(rect: CGRect) {
        topLeft = CGPoint(x: rect.minX, y: rect.minY)
        topRight = CGPoint(x: rect.maxX, y: rect.minY)
        bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
    }

    public var boundingBox: CGRect {
        let xMin = min(topRight.x, topLeft.x, bottomLeft.x, bottomRight.x)
        let yMin = min(topRight.y, topLeft.y, bottomLeft.y, bottomRight.y)
        let xMax = max(topRight.x, topLeft.x, bottomLeft.x, bottomRight.x)
        let yMax = max(topRight.y, topLeft.y, bottomLeft.y, bottomRight.y)

        return CGRect(x: xMin, y: yMin, width: xMax - xMin, height: yMax - yMin)
    }

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

    public static func + (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x + rhs.x, y: lhs.topLeft.y + rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x + rhs.x, y: lhs.topRight.y + rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x + rhs.x, y: lhs.bottomLeft.y + rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x + rhs.x, y: lhs.bottomRight.y + rhs.y))
    }

    public static func - (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x - rhs.x, y: lhs.topLeft.y - rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x - rhs.x, y: lhs.topRight.y - rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x - rhs.x, y: lhs.bottomLeft.y - rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x - rhs.x, y: lhs.bottomRight.y - rhs.y))
    }

    public static func * (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x * rhs.x, y: lhs.topLeft.y * rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x * rhs.x, y: lhs.topRight.y * rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x * rhs.x, y: lhs.bottomLeft.y * rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x * rhs.x, y: lhs.bottomRight.y * rhs.y))
    }

    public static func / (lhs: MUQuad, rhs: CGPoint) -> MUQuad {
        return MUQuad(topLeft: CGPoint(x: lhs.topLeft.x / rhs.x, y: lhs.topLeft.y / rhs.y),
                      topRight: CGPoint(x: lhs.topRight.x / rhs.x, y: lhs.topRight.y / rhs.y),
                      bottomLeft: CGPoint(x: lhs.bottomLeft.x / rhs.x, y: lhs.bottomLeft.y / rhs.y),
                      bottomRight: CGPoint(x: lhs.bottomRight.x / rhs.x, y: lhs.bottomRight.y / rhs.y))
    }
}
