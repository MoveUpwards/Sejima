//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Align left header with autolayout ###

let header = MUHeader()
header.textAlignment = .center
header.textAlignment = .center
header.title = "My header title"
header.titleFont = .boldSystemFont(ofSize: 24)
header.titleColor = .green
header.detail = "My header detail text"
header.detailFont = .boldSystemFont(ofSize: 12)
header.detailColor = .green

view.addSubview(header)
view.centerXAnchor
    .constraint(equalTo: header.centerXAnchor)
    .isActive = true
view.centerYAnchor
    .constraint(equalTo: header.centerYAnchor)
    .isActive = true

//: [Next](@next)
