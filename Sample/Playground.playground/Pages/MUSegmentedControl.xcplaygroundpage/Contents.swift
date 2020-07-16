//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

let view = UIView(frame: CGRect(x: 0, y: 0, width: 410, height: 50))
view.backgroundColor = .clear

PlaygroundPage.current.liveView = view

let segment = MUSegmentedControl()
//        segment.allowPanningGesture = false
//segment.borderWidth = 2
segment.indicatorInset = 0
//segment.indicatorHeight = 0.9
//segment.indicatorWidth = 0.9
//segment.indicatorOrigin = .bottomCenter
segment.segments = [
    MUSegmentItem(title: "Test 1", titleColor: .black, selectedTitleColor: .black,  selectedColor: .green),
    MUSegmentItem(title: "Test 2", titleColor: .black, selectedTitleColor: .black, selectedColor: .orange)
]

let line = UIView(frame: .init(x: 0, y: 48, width: 410, height: 2))
line.backgroundColor = .gray

view.addSubview(line)
view.addAutolayoutSubview(segment)

//: [Next](@next)
