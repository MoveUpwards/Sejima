//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Indicator with autolayout ###

let soloButton = MUCollectionButton(frame: CGRect(x: 5, y: 5, width: 120, height: 40))
soloButton.backgroundColor = UIColor.black.withAlphaComponent(0.7)
soloButton.borderColor = .orange
soloButton.borderWidth = 1.0
soloButton.textColor = .white
soloButton.selectedTextColor = .red
soloButton.indicatorColor = .orange
soloButton.textFont = .systemFont(ofSize: 16.0, weight: .bold)
soloButton.items = [.init(text: "Cancel")]

view.addSubview(soloButton)
soloButton.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
soloButton.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
