//
//  MUStringTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 12/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUStringTests: XCTestCase {

    func testSimpleCustomCharacterSet() {
        XCTAssertTrue("abc".isLetters)
        XCTAssertFalse("a4".isLetters)

        XCTAssertTrue("123".isDigits)
        XCTAssertFalse("a4".isDigits)

        XCTAssertTrue("abc".isAlphanumerics)
        XCTAssertTrue("123".isAlphanumerics)
        XCTAssertTrue("a4".isAlphanumerics)
        XCTAssertFalse("a-4".isAlphanumerics)
        XCTAssertFalse("*bold*".isAlphanumerics)

        XCTAssertTrue("a4 paper".isValidRegex("a4"))
        XCTAssertTrue("an a4 letter".isValidRegex("a4"))
        XCTAssertTrue("pa44ot".isValidRegex("a4"))
        XCTAssertTrue("this is a4".isValidRegex("a4"))
        XCTAssertFalse("not a3".isValidRegex("a4"))
        XCTAssertFalse("a-4".isValidRegex("a4"))
    }

    func testCompleteCustomCharacterSet() {
        // 1234
        XCTAssertTrue("1234".isAlphanumerics)
        XCTAssertTrue("1234".isDigits)
        XCTAssertFalse("1234".isLetters)
        XCTAssertFalse("1234".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertFalse("1234".isValidRegex("🦄")) // has a licorne

        // ABC
        XCTAssertTrue("ABC".isAlphanumerics)
        XCTAssertFalse("ABC".isDigits)
        XCTAssertTrue("ABC".isLetters)
        XCTAssertFalse("ABC".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertFalse("ABC".isValidRegex("🦄")) // has a licorne

        // 123ABC
        XCTAssertTrue("123ABC".isAlphanumerics)
        XCTAssertFalse("123ABC".isDigits)
        XCTAssertFalse("123ABC".isLetters)
        XCTAssertFalse("123ABC".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertFalse("123ABC".isValidRegex("🦄")) // has a licorne

        // _ABC_
        XCTAssertFalse("_ABC_".isAlphanumerics)
        XCTAssertFalse("_ABC_".isDigits)
        XCTAssertFalse("_ABC_".isLetters)
        XCTAssertFalse("_ABC_".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertFalse("_ABC_".isValidRegex("🦄")) // has a licorne

        // àé
        XCTAssertTrue("àé".isAlphanumerics)
        XCTAssertFalse("àé".isDigits)
        XCTAssertTrue("àé".isLetters)
        XCTAssertTrue("àé".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertFalse("àé".isValidRegex("🦄")) // has a licorne

        // èë
        XCTAssertTrue("èë".isAlphanumerics)
        XCTAssertFalse("èë".isDigits)
        XCTAssertTrue("èë".isLetters)
        XCTAssertTrue("èë".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertFalse("èë".isValidRegex("🦄")) // has a licorne

        // 🦄
        XCTAssertFalse("🦄".isAlphanumerics)
        XCTAssertFalse("🦄".isDigits)
        XCTAssertFalse("🦄".isLetters)
        XCTAssertFalse("🦄".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertTrue("🦄".isValidRegex("🦄")) // has a licorne

        // 🦄🦋
        XCTAssertFalse("🦄🦋".isAlphanumerics)
        XCTAssertFalse("🦄🦋".isDigits)
        XCTAssertFalse("🦄🦋".isLetters)
        XCTAssertFalse("🦄🦋".isValidRegex("[éèêëęėè]")) // has E with accent
        XCTAssertTrue("🦄🦋".isValidRegex("🦄")) // has a licorne
    }

    func testSize() {
        // String.boundingRect return height not null for null string
//        checkSize(for: "", font: .systemFont(ofSize: 17.0, weight: .regular))
        checkSize(for: "Short text", font: .systemFont(ofSize: 17.0, weight: .regular))
        checkSize(for: "THIS IS AN UPPERCASE", font: .systemFont(ofSize: 17.0, weight: .regular))
        checkSize(for: "A very long text that need more than one line",
                  font: .systemFont(ofSize: 17.0, weight: .regular))

//        checkSize(for: "", font: .systemFont(ofSize: 17.0, weight: .bold))
        checkSize(for: "Short text", font: .systemFont(ofSize: 17.0, weight: .bold))
        checkSize(for: "THIS IS AN UPPERCASE", font: .systemFont(ofSize: 17.0, weight: .bold))
        checkSize(for: "A very long text that need more than one line", font: .systemFont(ofSize: 17.0, weight: .bold))

//        checkSize(for: "", font: .systemFont(ofSize: 17.0, weight: .light))
        checkSize(for: "Short text", font: .systemFont(ofSize: 17.0, weight: .light))
        checkSize(for: "THIS IS AN UPPERCASE", font: .systemFont(ofSize: 17.0, weight: .light))
        checkSize(for: "A very long text that need more than one line", font: .systemFont(ofSize: 17.0, weight: .light))
    }

    private let label = UILabel()

    private func checkSize(for text: String, font: UIFont) {
        label.text = text
        label.font = font
        label.numberOfLines = 0

        var labelSize = label.sizeThatFits(CGSize(width: 200.0, height: .greatestFiniteMagnitude))
        var stringSize = text.constrainedSize(width: 200.0, font: font)

        XCTAssertEqual(stringSize.width, labelSize.width, accuracy: 0.5)
        XCTAssertEqual(stringSize.height, labelSize.height, accuracy: 0.5)

        labelSize = label.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: 200.0))
        stringSize = text.constrainedSize(height: 200.0, font: font)

        XCTAssertEqual(stringSize.width, labelSize.width, accuracy: 0.5)
        XCTAssertEqual(stringSize.height, labelSize.height, accuracy: 0.5)
    }
}
