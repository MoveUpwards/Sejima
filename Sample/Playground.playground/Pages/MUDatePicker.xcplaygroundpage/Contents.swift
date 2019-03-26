//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// Define the custom MUDatePicker

let redPicker = MUDatePicker(frame: CGRect(x: 0, y: 0, width: 375, height: 178))
redPicker.separatorHeight = 0.0
redPicker.backgroundColor = .red
redPicker.textColor = .brown

let datePicker = MUDatePicker(frame: CGRect(x: 0, y: 200, width: 375, height: 178))
datePicker.backgroundColor = .black
datePicker.textColor = .white
datePicker.separatorHeight = 1.0

datePicker.selectedDate = Date(year: -18)
datePicker.maximumDate = Date()
datePicker.minimumDate = Date(timeIntervalSince1970: -2208988800) // 1st January 1900

// View

let vc = UIViewController()
vc.view.backgroundColor = .yellow
vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 400)
vc.view.addSubview(redPicker)
vc.view.addSubview(datePicker)

PlaygroundPage.current.liveView = vc.view

//: [Next](@next)
