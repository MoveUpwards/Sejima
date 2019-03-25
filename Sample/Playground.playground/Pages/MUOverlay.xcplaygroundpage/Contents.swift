//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

let overlay = MUOverlay()
overlay.style = .custom(40)
overlay.backgroundColor = .red
overlay.borderWidth = 10
overlay.borderColor = .orange

view.addSubview(overlay)
overlay.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
overlay.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
