//
//  MUMatrixTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 18/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUMatrixTests: XCTestCase {

    func testInits() {
        let matrixEmpty = MUMatrix<Float>()
        let matrix1x4 = MUMatrix<Float>(arrayLiteral: [1.0, 2.0, 3.0, 4.0])
        let matrix1x3 = MUMatrix<Float>(rows: 1, columns: 3, repeatedValue: 0.0)

        XCTAssertEqual(matrixEmpty.rowsCount, 0)
        XCTAssertEqual(matrixEmpty.columnsCount, 0)
        XCTAssertEqual(matrix1x4.rowsCount, 1)
        XCTAssertEqual(matrix1x4.columnsCount, 4)
        XCTAssertEqual(matrix1x3.rowsCount, 1)
        XCTAssertEqual(matrix1x3.columnsCount, 3)

        XCTAssertEqual(matrix1x4.row(0), [1.0, 2.0, 3.0, 4.0])
        XCTAssertEqual(matrix1x4.column(0), [1.0])
    }

    func testFunctions() {
        var matrix2x2 = MUMatrix(rows: 2, columns: 2, repeatedValue: Float(0.0))
        // 0.0  0.0
        // 0.0  0.0
        matrix2x2.fillRow(0, value: 1.0)
        // 1.0  1.0
        // 0.0  0.0

        XCTAssertEqual(matrix2x2.column(0), [1.0, 0.0])
        XCTAssertEqual(matrix2x2.transpose().column(0), [1.0, 1.0])

        matrix2x2.insertRow(1, value: 2.0)
        // 1.0  1.0
        // 2.0  2.0
        // 0.0  0.0
        XCTAssertEqual(matrix2x2[1, 1], 2.0)

        let description = "[\n1.0 1.0 \n2.0 2.0 \n0.0 0.0 \n]"

        XCTAssertEqual(matrix2x2.description, description)

        matrix2x2.insertColumn(1, value: 1.0)
        // 1.0  1.0  1.0
        // 2.0  1.0  2.0
        // 0.0  1.0  0.0

        matrix2x2.swapValue(first: (1, 0), second: (1, 1))
        // 1.0  1.0  1.0
        // 1.0  2.0  2.0
        // 0.0  1.0  0.0

        var matrix4x3 = matrix2x2.resize(row: 4, column: 3)
        // 1.0  1.0  1.0
        // 1.0  2.0  2.0
        // 0.0  1.0  0.0
        // 0.0  0.0  0.0

        matrix4x3.fillColumn(0, value: 3.0)
        // 3.0  1.0  1.0
        // 3.0  2.0  2.0
        // 3.0  1.0  0.0
        // 3.0  0.0  0.0

        matrix4x3.rotate(firstRow: 0, secondRow: 1, cosine: cos(90.0), sine: sin(45.0))
        // 1.2084897    1.2537334   1.2537334
        // -3.8969314   -1.7470508  -1.7470508
        // 3.0          1.0         0.0
        // 3.0          1.0         0.0

        var matrix2x3 = matrix4x3.resize(row: 2, column: 3)
        // 1.2084897    1.2537334   1.2537334
        // -3.8969314   -1.7470508  -1.7470508

        let matrix1x2 = matrix2x3.jacobiSVD()
        XCTAssertEqual(matrix1x2.column(0), [5.0284944, 0.7802778])
        XCTAssertEqual(matrix2x3.column(0), [-4.0538096, 0.46168032])
    }
}
