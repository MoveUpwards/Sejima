//
//  MUKeyboardTests.swift
//  SejimaTests
//
//  Created by Damien Noël Dubuisson on 18/09/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import XCTest
@testable import Sejima

class MUKeyboardTests: XCTestCase {

    func testKeyboard() {
        let notif = NSNotification(name: NSNotification.Name("Test"),
                                   object: nil,
                                   userInfo: [UIResponder.keyboardAnimationDurationUserInfoKey: 2.0,
                                              UIResponder.keyboardAnimationCurveUserInfoKey: UInt(2),
                                              UIResponder.keyboardFrameEndUserInfoKey: CGRect.zero])
        let vc = UIViewController()
        // UIApplication.shared.keyWindow?.safeAreaInsets.bottom => Will be nil on Unit Test

        fakeOpenKeyboard(on: vc, with: notif)
        fakeCloseKeyboard(on: vc, with: notif)
    }

    func testFakeKeyboard() {
        let fakeNotif = NSNotification(name: NSNotification.Name("Test"), object: nil)
        let vc = UIViewController()

        fakeOpenKeyboard(on: vc, with: fakeNotif)
        fakeCloseKeyboard(on: vc, with: fakeNotif)
    }

    private func fakeOpenKeyboard(on vc: UIViewController, with notification: NSNotification) {
        vc.useKeyboard(true)
        vc.keyboardWillShow(notification)
        vc.keyboardDidShow(notification)
    }

    private func fakeCloseKeyboard(on vc: UIViewController, with notification: NSNotification) {
        vc.keyboardWillHide(notification)
        vc.keyboardDidHide(notification)
        vc.useKeyboard(false)
    }
}
