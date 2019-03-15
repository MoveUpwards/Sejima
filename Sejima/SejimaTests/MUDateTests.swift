//
//  MUDateTests.swift
//  SejimaTests
//
//  Created by Loïc GRIFFIE on 15/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUDateTests: XCTestCase {

    override func setUp() {
        super.setUp()
        NSTimeZone.default = TimeZone(abbreviation: "UTC")! //swiftlint:disable:this force_unwrapping
    }

    func testFromComponents() {
        let current = Date().addingTimeInterval(-86_400).timeIntervalSinceNow
        let date = Date(day: -1).timeIntervalSinceNow
        XCTAssertNotNil(date)

        // Cast to Int to avoid milliseconds
        XCTAssertEqual(Int(date), Int(current))
    }

    func testIsInToday() {
        XCTAssert(Date().isToday)
        let tomorrow = Date().addingTimeInterval(86_400)
        XCTAssertFalse(tomorrow.isToday)
        let yesterday = Date().addingTimeInterval(-86_400)
        XCTAssertFalse(yesterday.isToday)
    }

    func testDateString() {
        let date = Date(timeIntervalSince1970: 512)
        let formatter = DateFormatter()
        formatter.timeStyle = .none

        formatter.dateStyle = .short
        XCTAssertEqual(date.dateString(ofStyle: .short), formatter.string(from: date))

        formatter.dateStyle = .medium
        XCTAssertEqual(date.dateString(ofStyle: .medium), formatter.string(from: date))

        formatter.dateStyle = .long
        XCTAssertEqual(date.dateString(ofStyle: .long), formatter.string(from: date))

        formatter.dateStyle = .full
        XCTAssertEqual(date.dateString(ofStyle: .full), formatter.string(from: date))

        formatter.dateStyle = .none

        formatter.dateFormat = "dd/MM/yyyy"
        XCTAssertEqual(date.string(withFormat: "dd/MM/yyyy"), formatter.string(from: date))

        formatter.dateFormat = "HH:mm"
        XCTAssertEqual(date.string(withFormat: "HH:mm"), formatter.string(from: date))

        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        XCTAssertEqual(date.string(withFormat: "dd/MM/yyyy HH:mm"), formatter.string(from: date))

        formatter.dateFormat = "iiiii"
        XCTAssertEqual(date.string(withFormat: "iiiii"), formatter.string(from: date))
    }

    func testDateTimeString() {
        let date = Date(timeIntervalSince1970: 512)
        let formatter = DateFormatter()

        formatter.timeStyle = .short
        formatter.dateStyle = .short
        XCTAssertEqual(date.dateTimeString(ofStyle: .short), formatter.string(from: date))

        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        XCTAssertEqual(date.dateTimeString(ofStyle: .medium), formatter.string(from: date))

        formatter.timeStyle = .long
        formatter.dateStyle = .long
        XCTAssertEqual(date.dateTimeString(ofStyle: .long), formatter.string(from: date))

        formatter.timeStyle = .full
        formatter.dateStyle = .full
        XCTAssertEqual(date.dateTimeString(ofStyle: .full), formatter.string(from: date))
    }

    func testTimeString() {
        let date = Date(timeIntervalSince1970: 512)
        let formatter = DateFormatter()
        formatter.dateStyle = .none

        formatter.timeStyle = .short
        XCTAssertEqual(date.timeString(ofStyle: .short), formatter.string(from: date))

        formatter.timeStyle = .medium
        XCTAssertEqual(date.timeString(ofStyle: .medium), formatter.string(from: date))

        formatter.timeStyle = .long
        XCTAssertEqual(date.timeString(ofStyle: .long), formatter.string(from: date))

        formatter.timeStyle = .full
        XCTAssertEqual(date.timeString(ofStyle: .full), formatter.string(from: date))
    }

    func testDayInterval() {
        let offset = 12600.0
        // "1970-01-01 01:00:00 +0000"
        let date = Date(timeIntervalSince1970: offset)

        // start: "1970-01-01 00:00:00 +0000"
        // end: "1970-01-01 23:59:59 +0000"
        let (start, end) = Date().dayInterval(for: date)
        XCTAssertEqual(start.timeIntervalSince1970, date.addingTimeInterval(-offset).timeIntervalSince1970)
        XCTAssertEqual(end.timeIntervalSince1970, date.addingTimeInterval(86_399 - offset).timeIntervalSince1970)
    }

    func testYearsSince() {
        let date = Date(year: -20)
        let years = Date().yearsSince(date)
        XCTAssertEqual(years, 20)
    }

    func testTimeInterval() {
        XCTAssertEqual(TimeInterval.second, 1)
        XCTAssertEqual(TimeInterval.minute, 60)
        XCTAssertEqual(TimeInterval.hour, 3600)
        XCTAssertEqual(TimeInterval.day, 86400)
    }
}
