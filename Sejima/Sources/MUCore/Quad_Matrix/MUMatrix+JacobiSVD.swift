//
//  MUMatrix+JacobiSVD.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 13/12/2018.
//  Copyright © 2018 Loïc GRIFFIE. All rights reserved.
//

import Foundation

extension MUMatrix {
    /// Jacobi Singular Value Decomposition
    public mutating func jacobiSVD(n: Int = -1) -> MUMatrix {
        var nilRef: MUMatrix?
        return jacobiSVD(&nilRef, n: n)
    }

    /// Jacobi Singular Value Decomposition
    public mutating func jacobiSVD(_ matrixV: inout MUMatrix?, n: Int = -1) -> MUMatrix {
        // Calculate Matrix W
        var matrixW = MUMatrix(rows: rowsCount, columns: 1, repeatedValue: T(0))
        datas.enumerated().forEach { index, row in
            var combinedRow: T = 0

            row.forEach { item in
                combinedRow += item * item
            }

            matrixW[index, 0] = combinedRow

            matrixV?.fillRow(index, value: T(0))
            matrixV?[index, index] = T(1)
        }

        performRotation(with: &matrixW, matrixV: &matrixV)

        // Update Matrix W member values
        (0 ..< rowsCount).forEach { rowIndex in
            var combinedValue: T = 0
            (0 ..< columnsCount).forEach { columnIndex in
                combinedValue += self[rowIndex, columnIndex] * self[rowIndex, columnIndex]
            }
            matrixW[rowIndex, 0] = sqrt(combinedValue)
        }

        //  Sort members of Matrix w and Matrix V
        (0 ..< rowsCount - 1).forEach { row1Index in
            (row1Index + 1 ..< rowsCount).forEach { row2Index in
                let row1Number = matrixW[row1Index, 0]
                let row2Number = matrixW[row2Index, 0]
                if row1Number < row2Number {
                    matrixW[row1Index, 0] = row2Number
                    matrixW[row2Index, 0] = row1Number

                    if matrixV != nil {
                        (0 ..< columnsCount).forEach { columnIndex in
                            swapValue(first: (row1Index, columnIndex), second: (row2Index, columnIndex))
                            matrixV?.swapValue(first: (row1Index, columnIndex), second: (row2Index, columnIndex))
                        }
                    }
                }
            }
        }

        guard matrixV != nil else {
            return matrixW
        }

        factor(n: n < 0 ? columnsCount : n, with: matrixW)

        return matrixW
    }

    private mutating func performRotation(with matrixW: inout MUMatrix, matrixV: inout MUMatrix?) {
        // Calculate appropriate cosine and sine values, and perform Givens Rotation
        var cosine: T = 0
        var sine: T = 0

        for _ in (0 ..< max(rowsCount, 30)) {
            var changed = false

            (0 ..< rowsCount - 1).forEach { firstIndex in
                for secondIndex in (firstIndex + 1 ..< rowsCount) {
                    var wA = matrixW[firstIndex, 0]
                    var wB = matrixW[secondIndex, 0]
                    var p: T = 0

                    (0 ..< columnsCount).forEach { valueIndex in
                        p += self[firstIndex, valueIndex] * self[secondIndex, valueIndex]
                    }

                    guard abs(p) > .epsilon * sqrt(wA * wB) else {
                        continue
                    }

                    p *= 2
                    let beta = wA - wB
                    let gamma = T.hypotenuse(p, beta)

                    if beta < 0 {
                        sine = sqrt(((gamma - beta) * T(0.5)) / gamma)
                        cosine = p / (gamma * sine * T(2.0))
                    } else {
                        cosine = sqrt((gamma + beta) / (gamma * T(2.0)))
                        sine = p / (gamma * cosine * T(2.0))
                    }

                    wA = 0
                    wB = 0
                    (0 ..< columnsCount).forEach { valueIndex in
                        let firstValue = self[firstIndex, valueIndex]
                        let secondValue = self[secondIndex, valueIndex]
                        let t0 = cosine * firstValue + sine * secondValue
                        let t1 = -sine * firstValue + cosine * secondValue

                        self[firstIndex, valueIndex] = t0
                        self[secondIndex, valueIndex] = t1
                        wA += t0 * t0
                        wB += t1 * t1
                    }

                    matrixW[firstIndex, 0] = wA
                    matrixW[secondIndex, 0] = wB
                    changed = true

                    matrixV?.rotate(firstRow: firstIndex, secondRow: secondIndex, cosine: cosine, sine: sine)
                }
            }

            if !changed {
                break
            }
        }
    }

    private mutating func factor(n: Int, with matrixW: MUMatrix) {
        // Factor in Matrix V if exists
        (0 ..< n).forEach { index in
            var testValue = index < rowsCount ? matrixW[index, 0] : 0
            while testValue <= T(.leastNormalMagnitude) {
                // if we got a zero singular value, then in order to get the corresponding left singular vector
                // we generate a random vector, project it to the previously computed left singular vectors,
                // subtract the projection and normalize the difference.
                let valueSeed = T(1.0) / T(columnsCount)
                (0 ..< columnsCount).forEach { columnIndex in
                    self[index, columnIndex] = Int.random(in: 0 ..< 256) != 0 ? valueSeed : -valueSeed
                }

                (0 ..< 2).forEach { _ in
                    (0 ..< index).forEach { secondIndex in
                        var combinedValue1: T = 0
                        (0 ..< columnsCount).forEach { columnIndex in
                            combinedValue1 += self[index, columnIndex] * self[secondIndex, columnIndex]
                        }

                        var combinedValue2: T = 0
                        (0 ..< columnsCount).forEach { columnIndex in
                            let calcValue = self[index, columnIndex] - combinedValue1 * self[secondIndex, columnIndex]
                            self[index, columnIndex] = calcValue
                            combinedValue2 += abs(calcValue)
                        }

                        combinedValue2 = combinedValue2 != 0 ? T(1) / combinedValue2 : T(0)
                        (0 ..< columnsCount).forEach { columnIndex in
                            self[index, columnIndex] *= combinedValue2
                        }
                    }
                }

                testValue = 0
                (0 ..< columnsCount).forEach { columnIndex in
                    testValue += self[index, columnIndex] * self[index, columnIndex]
                }
                testValue = sqrt(testValue)
            }

            let value = T(1) / testValue
            (0 ..< columnsCount).forEach { columnIndex in
                self[index, columnIndex] *= value
            }
        }
    }
}
