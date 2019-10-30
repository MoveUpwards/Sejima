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
segmentedControl.segments = [MUSegmentItem(image: UIImage(named: "reddit") ?? UIImage(),
                                           imageColor: .orange,
                                           selectedColor: .blue),
                             MUSegmentItem(title: "WOMAN", selectedColor: .green)]

view.addSubview(segmentedControl)
segmentedControl.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
segmentedControl.topAnchor
    .constraint(equalTo: header.bottomAnchor, constant: 20.0)
    .isActive = true

//: [Next](@next)
