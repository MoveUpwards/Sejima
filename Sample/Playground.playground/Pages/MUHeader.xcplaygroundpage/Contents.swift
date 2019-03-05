//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 310, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Header with autolayout ###

let header = MUHeader()
header.textAlignment = .center
header.textAlignment = .center
header.title = "My header title"
header.titleFont = .boldSystemFont(ofSize: 24)
header.titleColor = .green
header.detail = "My header detail text"
header.detailFont = .boldSystemFont(ofSize: 12)
header.detailColor = .green

view.addSubview(header)
header.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
header.topAnchor
    .constraint(equalTo: view.topAnchor, constant: 20.0)
    .isActive = true

// ### Segmented control with autolayout ###

let segmentedControl = MUSegmentedControl()
segmentedControl.cornerRadius = 8.0
segmentedControl.borderWidth = 1.0
segmentedControl.titleColor = .white
segmentedControl.selectedTitleColor = .black
segmentedControl.indicatorInset = 4.0
segmentedControl.segments = [MUSegmentItem(title: "MAN", selectedColor: UIColor(red: 48.0/255.0, green: 208.0/255.0, blue: 248.0/255.0, alpha: 1.0)),
                             MUSegmentItem(title: "WOMAN", selectedColor: UIColor(red: 240.0/255.0, green: 182.0/255.0, blue: 241.0/255.0, alpha: 1.0))]

view.addSubview(segmentedControl)
segmentedControl.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
segmentedControl.topAnchor
    .constraint(equalTo: header.bottomAnchor, constant: 20.0)
    .isActive = true

//: [Next](@next)
