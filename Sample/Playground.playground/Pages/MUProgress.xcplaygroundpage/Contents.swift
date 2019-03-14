//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Empty one ###

let progress = MUProgress(frame: CGRect(x: 20, y: 50, width: 260, height: 40))
progress.title = "MY TITLE"
progress.titleColor = .white
progress.trackColor = .blue
progress.color = .green
progress.thickness = 10.0
progress.indicatorMultiplier = 100

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    progress.set(progress: 0.8, duration: 1)
}

view.addSubview(progress)
progress.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
progress.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
