//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### MUProportionalBar with autolayout ###
let bar = MUProportionalBar()
bar.style = .round

bar.items = [
    MUProportionalItem(value: 0.6, title: "Low", color: .green),
    MUProportionalItem(value: 0.3, title: "Medium", color: .orange),
    MUProportionalItem(value: 0.1, title: "High", color: .red)
]

view.addSubview(bar)

bar.widthAnchor
    .constraint(equalTo: view.widthAnchor)
    .isActive = true
bar.heightAnchor
    .constraint(equalTo: view.heightAnchor)
    .isActive = true

//: [Next](@next)
