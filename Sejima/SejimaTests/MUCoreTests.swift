//
//  MUCoreTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import XCTest
@testable import Sejima

class MUCoreTests: XCTestCase {

    func testMUNibView() {
        // Testing MUNibView with class without xib file will crash as
        // UINib instantiate function doesn't throw execption and crash instead

//        let fakeOne = FakeView()
//        XCTAssertNil(fakeOne)
    }

    func testMUWeakProxy() {
        var fakeProxy: FakeProxy? = FakeProxy()
        XCTAssertNotNil(fakeProxy)

        var proxy: MUWeakProxy?
        if let myFakeProxy = fakeProxy {
            proxy = MUWeakProxy(myFakeProxy)
        }
        XCTAssertNotNil(proxy)

        fakeProxy = nil
        // Garbage collector has not release fakeProxy, see how to force it.
//        XCTAssertNil(proxy?.forwardingTarget(for: #selector(FakeProxy.printMe)))
//        XCTAssertFalse(proxy?.responds(to: #selector(FakeProxy.printMe)) ?? true)

        proxy = nil
        XCTAssertNil(proxy)
    }
}

internal class FakeView: MUNibView {
}

internal class FakeProxy: Weakable {
    func updateIfNeeded() { }

    @objc
    internal func printMe() { }
}
