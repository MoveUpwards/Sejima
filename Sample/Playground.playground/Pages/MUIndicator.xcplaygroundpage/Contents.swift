//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Indicator with autolayout ###

let indicator = MUIndicator(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
indicator.color = .orange
indicator.cornerRadius = 6
indicator.format = "%.1f"
indicator.valueColor = .white
indicator.valueFont = .systemFont(ofSize: 24)
indicator.textAlignment = .center
indicator.set(value: 60, duration: 3.25)

view.addSubview(indicator)
indicator.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
indicator.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
