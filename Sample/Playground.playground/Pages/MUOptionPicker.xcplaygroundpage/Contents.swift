//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// Define the custom MUDatePicker

let optionPicker = MUOptionPicker(frame: CGRect(x: 0, y: 0, width: 375, height: 178))
optionPicker.backgroundColor = .black
optionPicker.selectedColor = .red
optionPicker.unselectedColor = .purple
optionPicker.textFont = .systemFont(ofSize: 18.0, weight: .bold)
optionPicker.add(datas: [.init(image: nil, text: "Left"),
                         .init(image: nil, text: "Right")])

// View

let vc = UIViewController()
vc.view.backgroundColor = .yellow
vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 400)
vc.view.addSubview(optionPicker)

PlaygroundPage.current.liveView = vc.view

//: [Next](@next)
