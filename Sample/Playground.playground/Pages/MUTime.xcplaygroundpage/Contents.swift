//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

let time = MUTime()
time.backgroundColor = UIColor.white
time.indicatorMinValue = 0
time.indicatorMaxValue = 120
time.indicatorStartAngle = 270
time.indicatorEndAngle = 90
time.animationDuration = 0.75
time.indicatorLineCap = .round
time.color = .white
time.timeBackgroundColor = .green
time.indicatorColor = .orange
time.indicatorWidth = 2
time.format = "%.f'"

view.addSubview(time)
time.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
time.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    time.set(value: 90, animated: true, progress: { current in
        print(current)
    })
}

//: [Next](@next)
