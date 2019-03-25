//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

let dateSlider = MUDateSlider()
dateSlider.backgroundColor = .black
dateSlider.dayFont = .systemFont(ofSize: 10)
dateSlider.unselectedDayColor = .black
dateSlider.selectedDayColor = .white
dateSlider.numberFont = .boldSystemFont(ofSize: 18)
dateSlider.unselectedNumberColor = .black
dateSlider.selectedNumberColor = .white
dateSlider.monthFont = .systemFont(ofSize: 10)
dateSlider.unselectedMonthColor = .black
dateSlider.selectedMonthColor = .white
dateSlider.radius = 4
dateSlider.unselectedBorderWidth = 0
dateSlider.selectedBorderWidth = 1
dateSlider.unselectedBorderColor = .clear
dateSlider.selectedBorderColor = .black
dateSlider.unselectedBackgroundColor = .red
dateSlider.selectedBackgroundColor = .green
dateSlider.selectedMarkerColor = .green
dateSlider.unselectedMarkerColor = .purple
dateSlider.markerLineHeight = 8

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    dateSlider.today()
}

view.addSubview(dateSlider)
dateSlider.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
dateSlider.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
