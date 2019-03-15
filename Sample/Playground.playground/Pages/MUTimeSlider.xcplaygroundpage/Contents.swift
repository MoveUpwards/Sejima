//: [Previous](@previous)

import UIKit
import Sejima
import PlaygroundSupport

let debugSlider = MUTimeSlider()
debugSlider.borderWidth = 3.0
debugSlider.borderColor = .red
debugSlider.indicatorColor = .black
debugSlider.indicatorWidth = 3.0
debugSlider.timeColor = .black
debugSlider.timeFont = .systemFont(ofSize: 12.0, weight: .bold)
debugSlider.timeTopPadding = 45.0
debugSlider.timeHorizontalPadding = 10.0
debugSlider.duration = 5.0 * 60
debugSlider.set(percentage: 0.0)

DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
    debugSlider.set(percentage: 60.0)
}

let timeSlider = MUTimeSlider()
timeSlider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
timeSlider.duration = 115.0 * 60

DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
    timeSlider.set(positionX: 60.0)
}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 215))
view.backgroundColor = .white
view.addSubview(debugSlider)
view.addSubview(timeSlider)

debugSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.0).isActive = true
debugSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.0).isActive = true
debugSlider.topAnchor.constraint(equalTo: view.topAnchor, constant: 5.0).isActive = true
debugSlider.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

timeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.0).isActive = true
timeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.0).isActive = true
timeSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0).isActive = true
timeSlider.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

PlaygroundPage.current.liveView = view

//: [Next](@next)
