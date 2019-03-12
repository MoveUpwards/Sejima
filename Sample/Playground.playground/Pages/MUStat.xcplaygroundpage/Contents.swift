//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

let stat = MUStat()
stat.valueColor = .white
stat.unitColor = .orange
stat.detailColor = .gray
stat.valueFont = .systemFont(ofSize: 32, weight: .regular)
stat.unitFont = .systemFont(ofSize: 13, weight: .regular)
stat.detailFont = .systemFont(ofSize: 11, weight: .semibold)
stat.format = "%.1f"
stat.value = 4.2
stat.unit = "km/h"
stat.detail = "average speed"
stat.showSeparator = true
stat.separatorColor = .green
stat.separatorWidth = 5

view.addSubview(stat)
stat.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
stat.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
