//
//  MUTransform3D.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 04/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import UIKit

extension CATransform3D {
    // See: https://github.com/joshrl/FreeTransform/blob/master/FreeTransform/UIView%2BQuadrilateral.m
    /// Create CATransform3D to fit quad inside a given bounds
    public init(toFit quad: MUQuad, from bounds: CGRect) {
        let x1a = quad.topLeft.x
        let y1a = quad.topLeft.y
        let x2a = quad.topRight.x
        let y2a = quad.topRight.y
        let x3a = quad.bottomLeft.x
        let y3a = quad.bottomLeft.y
        let x4a = quad.bottomRight.x
        let y4a = quad.bottomRight.y

        let y21 = y2a - y1a
        let y32 = y3a - y2a
        let y43 = y4a - y3a
        let y14 = y1a - y4a
        let y31 = y3a - y1a
        let y42 = y4a - y2a

        let a = -bounds.height * (x2a * x3a * y14 + x2a * x4a * y31 - x1a * x4a * y32 + x1a * x3a * y42)
        let b = bounds.width * (x2a * x3a * y14 + x3a * x4a * y21 + x1a * x4a * y32 + x1a * x2a * y43)
        let c = -bounds.height * bounds.width * x1a * (x4a * y32 - x3a * y42 + x2a * y43)

        let d = bounds.height
            * (-x4a * y21 * y3a + x2a * y1a * y43 - x1a * y2a * y43 - x3a * y1a * y4a + x3a * y2a * y4a)
        let e = bounds.width * (x4a * y2a * y31 - x3a * y1a * y42 - x2a * y31 * y4a + x1a * y3a * y42)
        let f = -bounds.width
            * (x4a * (bounds.height * y1a * y32) - x3a * bounds.height * y1a * y42 + bounds.height * x2a * y1a * y43)

        let g = bounds.height * (x3a * y21 - x4a * y21 + (-x1a + x2a) * y43)
        let h = bounds.width * (-x2a * y31 + x4a * y31 + (x1a - x3a) * y42)
        var i = bounds.height * bounds.width * (-x3a * y2a + x4a * y2a + x2a * y3a - x4a * y3a - x2a * y4a + x3a * y4a)

        if abs(i) < .epsilon {
            i = .epsilon * (i > 0.0 ? 1.0 : -1.0)
        }

        self.init(m11: a / i, m12: d / i, m13: 0.0, m14: g / i, m21: b / i, m22: e / i, m23: 0.0, m24: h / i,
                  m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0, m41: c / i, m42: f / i, m43: 0.0, m44: 1.0)
    }

    // See: https://github.com/agens-no/AGGeometryKit/blob/master/AGGeometryKit/Categories/UIImage%2BAGKQuad.m
    /// Create CATransform3D to fit quad inside a given quad
    public init(perspectiveFrom quad: MUQuad, to destinationQuad: MUQuad) {
        var matrixA: MUMatrix<CGFloat>
        var matrixB: MUMatrix<CGFloat>
        (matrixA, matrixB) = CATransform3D.perspectiveMatrices(from: quad, to: destinationQuad)

        // Solve for the two matrices
        matrixA = matrixA.transpose()

        var matrixV: MUMatrix? = MUMatrix(rows: matrixA.rowsCount, columns: matrixA.rowsCount, repeatedValue: CGFloat())
        let matrixW = matrixA.jacobiSVD(&matrixV)
        let matrixX = matrixA.singleValueBackSubstitution(row: matrixA.rowsCount, column: matrixA.columnsCount,
                                                          wMatrix: matrixW, vMatrix: matrixV, bMatrix: matrixB)

        var perspectiveMatrix = matrixX.resize(row: 3, column: 3).transpose()
        perspectiveMatrix.insertColumn(2, value: 0)
        perspectiveMatrix.insertRow(2, value: 0)
        perspectiveMatrix[2, 2] = 1
        perspectiveMatrix[3, 3] = 1

        self.init(m11: perspectiveMatrix[0, 0],
                  m12: perspectiveMatrix[0, 1],
                  m13: perspectiveMatrix[0, 2],
                  m14: perspectiveMatrix[0, 3],
                  m21: perspectiveMatrix[1, 0],
                  m22: perspectiveMatrix[1, 1],
                  m23: perspectiveMatrix[1, 2],
                  m24: perspectiveMatrix[1, 3],
                  m31: perspectiveMatrix[2, 0],
                  m32: perspectiveMatrix[2, 1],
                  m33: perspectiveMatrix[2, 2],
                  m34: perspectiveMatrix[2, 3],
                  m41: perspectiveMatrix[3, 0],
                  m42: perspectiveMatrix[3, 1],
                  m43: perspectiveMatrix[3, 2],
                  m44: perspectiveMatrix[3, 3])
    }

    private static func perspectiveMatrices(from quad: MUQuad,
                                            to destinationQuad: MUQuad) -> (MUMatrix<CGFloat>, MUMatrix<CGFloat>) {
        // Calculate the two required matrices
        var matrixA = MUMatrix(rows: 8, columns: 8, repeatedValue: CGFloat())
        var matrixB = MUMatrix(rows: 8, columns: 1, repeatedValue: CGFloat())

        (0 ..< 4).forEach { i in
            let source = quad.point(i)
            let destination = destinationQuad.point(i)

            matrixA[i, 0] = source.x
            matrixA[i, 1] = source.y
            matrixA[i, 2] = 1.0
            matrixA[i + 4, 3] = source.x
            matrixA[i + 4, 4] = source.y
            matrixA[i + 4, 5] = 1.0

            matrixA[i, 3] = 0.0
            matrixA[i, 4] = 0.0
            matrixA[i, 5] = 0.0
            matrixA[i + 4, 0] = 0.0
            matrixA[i + 4, 1] = 0.0
            matrixA[i + 4, 2] = 0.0

            matrixA[i, 6] = -source.x * destination.x
            matrixA[i, 7] = -source.y * destination.x
            matrixA[i + 4, 6] = -source.x * destination.y
            matrixA[i + 4, 7] = -source.y * destination.y

            matrixB[i, 0] = destination.x
            matrixB[i + 4, 0] = destination.y
        }

        return (matrixA, matrixB)
    }
}
