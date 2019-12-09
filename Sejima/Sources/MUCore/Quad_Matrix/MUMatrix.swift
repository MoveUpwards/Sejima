//
//  MUMatrix.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 12/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import Foundation

/// MUMatrix struct of floating point elements
public struct MUMatrix<T: MUFloatingPoint & CustomStringConvertible> {
    /// 2D array of matrix datas.
    public private(set) var datas: [[T]]
    /// Number of rows.
    public private(set) var rowsCount: Int
    /// Number of columns.
    public private(set) var columnsCount: Int

    private init() {
        datas = [[T]]()
        rowsCount = 0
        columnsCount = 0
    }

    /// Initialize a matrix with a single value repeated on each rows and columns.
    public init(rows: Int, columns: Int, repeatedValue: T) {
        datas = [[T]](repeating: [T](repeating: repeatedValue, count: columns), count: rows)
        rowsCount = rows
        columnsCount = columns
    }

    /// Accesses the element at the specified position.
    public subscript(row: Int, column: Int) -> T {
        get {
            checkRow(row)
            checkColumn(column)
            return datas[row][column]
        }

        set {
            checkRow(row)
            checkColumn(column)
            datas[row][column] = newValue
        }
    }

    // MARK: - Public functions

    /// Get the row at the specified index.
    public func row(_ index: Int) -> [T] {
        checkRow(index)
        return datas[index]
    }

    /// Get the column at the specified index.
    public func column(_ index: Int) -> [T] {
        checkColumn(index)
        return datas.map { $0[index] }
    }

    /// Flips the matrix over its diagonal.
    public func transpose() -> MUMatrix {
        var transposed = MUMatrix()
        transposed.rowsCount = columnsCount
        transposed.columnsCount = rowsCount
        transposed.datas = columns()
        return transposed
    }

    /// Resize the matrix and crop values if new matrix is smaller or add 0 if new matrix is bigger.
    public func resize(row: Int, column: Int) -> MUMatrix {
        var resultMatrix = MUMatrix(rows: row, columns: column, repeatedValue: T(0))
        var flatDatas = datas.flatMap { $0 }

        for rowIndex in (0 ..< row) {
            for columnIndex in (0 ..< column) {
                guard !flatDatas.isEmpty else {
                    return resultMatrix
                }
                resultMatrix[rowIndex, columnIndex] = flatDatas[0]
                flatDatas = Array(flatDatas.dropFirst())
            }
        }

        return resultMatrix
    }

    /// Jacobi Single Value Backward Substitution.
    public func singleValueBackSubstitution(row: Int,
                                            column: Int,
                                            wMatrix: MUMatrix,
                                            vMatrix: MUMatrix?,
                                            bMatrix: MUMatrix?) -> MUMatrix {
        let bCols = bMatrix?.columnsCount ?? column
        var xMatrix = MUMatrix(rows: row, columns: bCols, repeatedValue: T(0))
        var threshold: T = 0

        // Calculate threshold
        (0 ..< min(row, column)).forEach { rowIndex in
            threshold += wMatrix[rowIndex, 0]
        }
        threshold *= .epsilon

        // Apply threshold to Matrix X
        for rowIndex in (0 ..< min(row, column)) {
            var wValue = wMatrix[rowIndex, 0]
            if abs(wValue) <= threshold {
                continue
            }
            wValue = T(1) / wValue

            if bCols == 1 {
                var combinedValue: T = 0
                if let bMatrix = bMatrix {
                    (0 ..< column).forEach { columnIndex in
                        combinedValue += self[rowIndex, columnIndex] * bMatrix[columnIndex, 0]
                    }
                } else {
                    combinedValue = self[0, 0]
                }
                combinedValue *= wValue

                (0 ..< row).forEach { columnIndex in
                    if let vValue = vMatrix?[rowIndex, columnIndex] {
                        xMatrix[columnIndex, 0] = xMatrix[columnIndex, 0] + combinedValue * vValue
                    }
                }
            } else {
                var bufferMatrix = MUMatrix(rows: 1, columns: bCols, repeatedValue: T(0))
                if let bMatrix = bMatrix {
                    matrixAXPY(row: column, column: bCols, aMatrix: bMatrix, yMatrix: &bufferMatrix)

                    (0 ..< bCols).forEach { columnIndex in
                        bufferMatrix[0, columnIndex] = bufferMatrix[0, columnIndex] * wValue
                    }
                } else {
                    (0 ..< bCols).forEach { columnIndex in
                        bufferMatrix[0, columnIndex] = self[rowIndex, columnIndex] * wValue
                    }
                }

                vMatrix?.matrixAXPY(row: column, column: bCols, aMatrix: bufferMatrix, yMatrix: &xMatrix)
            }
        }

        return xMatrix
    }

    // MARK: - Private functions

    private func checkRow(_ index: Int) {
        precondition(index >= 0 && index < rowsCount, "Row index out of bounds")
    }

    private func checkColumn(_ index: Int) {
        precondition(index >= 0 && index < columnsCount, "Column index out of bounds")
    }

    private func rows() -> [[T]] {
        return datas
    }

    private func columns() -> [[T]] {
        return datas.reduce([[T]](repeating: [T](), count: columnsCount), { arr, rows in
            var array = arr
            (0 ..< columnsCount).forEach { i in
                array[i].append(rows[i])
            }
            return array
        })
    }

    // This method is mostly untested. It has been included for the cases where the
    // `singleValueBackSubstitution` method has a b column count greater than one,
    // but this does not occur with perspective correction (our curent use case) and
    // therefore I have not been able to test it thoroughly. I've included it here
    // for completeness.
    //
    // y[0:m,0:n] += diag(a[0:1,0:m]) * x[0:m,0:n]
    private func matrixAXPY(row: Int, column: Int, aMatrix: MUMatrix, yMatrix: inout MUMatrix) {
        let xRowsCount = rowsCount
        let yRowsCount = yMatrix.rowsCount

        (0 ..< row).forEach { rowIndex in
            let aValue = aMatrix[rowIndex, 0]
            var xColumnIndex = 0
            var yColumnIndex = 0

            (0 ..< column).forEach { _ in
                // Account for different Matrix dimensions
                let xColWrap = rowIndex / xRowsCount
                if xColWrap >= 1 {
                    xColumnIndex += xColWrap
                }

                let yColWrap = rowIndex / yRowsCount
                if yColWrap >= 1 {
                    yColumnIndex += yColWrap
                }

                // xMatrix should not change in this method make sure we have enough xMatrix columns
                if xColumnIndex < columnsCount {
                    let yValue = yMatrix[(rowIndex % yRowsCount), yColumnIndex]
                    let xValue = self[(rowIndex % xRowsCount), xColumnIndex]
                    yMatrix[(rowIndex % yRowsCount), yColumnIndex] = yValue + aValue * xValue
                }

                xColumnIndex += 1
                yColumnIndex += 1
            }
        }
    }

    // MARK: - Mutating functions

    /// Fill the selected row at index with a repeated value.
    public mutating func fillRow(_ index: Int, value: T) {
        checkRow(index)
        datas[index] = [T](repeating: value, count: columnsCount)
    }

    /// Fill the selected column at index with a repeated value.
    public mutating func fillColumn(_ index: Int, value: T) {
        checkColumn(index)
        (0 ..< rowsCount).forEach { i in
            datas[i][index] = value
        }
    }

    /// Insert a new row at selected index and fill it with a repeated value.
    @discardableResult
    public mutating func insertRow(_ index: Int, value: T) -> MUMatrix {
        checkRow(index)
        rowsCount += 1
        datas.insert([T](repeating: value, count: columnsCount), at: index)
        return self
    }

    /// Insert a new column at selected index and fill it with a repeated value.
    @discardableResult
    public mutating func insertColumn(_ index: Int, value: T) -> MUMatrix {
        checkColumn(index)
        columnsCount += 1
        (0 ..< rowsCount).forEach { i in
            datas[i].insert(value, at: index)
        }
        return self
    }

    /// Perform a rotation in Euclidean space.
    public mutating func rotate(firstRow: Int, secondRow: Int, cosine: T, sine: T) {
        (0 ..< columnsCount).forEach { index in
            let t0 = self[firstRow, index] * cosine + self[secondRow, index] * sine
            let t1 = self[secondRow, index] * cosine - self[firstRow, index] * sine
            self[firstRow, index] = t0
            self[secondRow, index] = t1
        }
    }

    /// Swap first and second value at specified row/column.
    public mutating func swapValue(first: (row: Int, column: Int), second: (row: Int, column: Int)) {
        let temp = self[first.row, first.column]
        self[first.row, first.column] = self[second.row, second.column]
        self[second.row, second.column] = temp
    }
}

extension MUMatrix: CustomStringConvertible {
    /// A textual representation of this instance.
    public var description: String {
        var text = "[\n"
        (0 ..< rowsCount).forEach { row in
            (0 ..< columnsCount).forEach { column in
                text += String(datas[row][column].description) + " "
            }
            text += "\n"
        }
        text += "]"
        return text
    }
}

extension MUMatrix: ExpressibleByArrayLiteral {
    /// The type of the elements of an array literal.
    public typealias ArrayLiteralElement = [T]

    /// Creates an instance initialized with the given elements.
    public init(arrayLiteral elements: [T]...) {
        datas = elements
        rowsCount = elements.count
        columnsCount = rowsCount > 0 ? elements[0].count : 0
    }
}
