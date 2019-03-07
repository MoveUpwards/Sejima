//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Add pin code with autolayout ###

let pinCode = MUPinCode()
pinCode.pinCount = 4
pinCode.cellColor = .orange
pinCode.cellCornerRadius = 10.0
pinCode.cellFont = UIFont.systemFont(ofSize: 24.0, weight: .bold)

view.addSubview(pinCode)
pinCode.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
pinCode.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
