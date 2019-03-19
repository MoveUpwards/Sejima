//: [Previous](@previous)

import UIKit
import Sejima
import PlaygroundSupport

let numberSlider = MUNumberSlider(frame: CGRect(x: 0, y: 0, width: 375, height: 150))

let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 215))
view.backgroundColor = .white
view.addSubview(numberSlider)

numberSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
numberSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

//: [Next](@next)
