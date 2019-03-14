//: [Previous](@previous)

import UIKit
import Sejima
import PlaygroundSupport

let counter = MULabelCounter(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
counter.count(to: 100, duration: 2)

let counterEaseIn = MULabelCounter(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
counterEaseIn.animationType = .easeIn
counterEaseIn.rate = 3
counterEaseIn.format = "%.2f"
counterEaseIn.count(to: 100, duration: 2)

let counterEaseOut = MULabelCounter(frame: CGRect(x: 0, y: 100, width: 200, height: 50))
counterEaseOut.rate = 3
counterEaseOut.animationType = .easeOut
counterEaseOut.count(to: 100, duration: 2)

let counterEaseInOut = MULabelCounter(frame: CGRect(x: 0, y: 150, width: 200, height: 50))
counterEaseInOut.rate = 3
counterEaseInOut.animationType = .easeOut
counterEaseInOut.count(to: 100, duration: 2)

let counterAutoLayout = MULabelCounter()
counterAutoLayout.rate = 3
counterAutoLayout.format = "%.1f"
counterAutoLayout.animationType = .easeOut
counterAutoLayout.count(to: 100, duration: 2)

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
view.backgroundColor = .white
view.addSubview(counter)
view.addSubview(counterEaseIn)
view.addSubview(counterEaseOut)
view.addSubview(counterEaseInOut)
view.addSubview(counterAutoLayout)

view.leadingAnchor.constraint(equalTo: counterAutoLayout.leadingAnchor).isActive = true
view.trailingAnchor.constraint(equalTo: counterAutoLayout.trailingAnchor).isActive = true
view.bottomAnchor.constraint(equalTo: counterAutoLayout.bottomAnchor).isActive = true
counterAutoLayout.heightAnchor.constraint(equalToConstant: 50).isActive = true

PlaygroundPage.current.liveView = view

//: [Next](@next)
