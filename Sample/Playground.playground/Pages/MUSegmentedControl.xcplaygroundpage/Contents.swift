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
segment.selectedColor = .green
//segment.indicatorHeight = 0.9
//segment.indicatorWidth = 0.9
//segment.indicatorOrigin = .bottomCenter
segment.segments = [
    MUSegmentItem(title: "Test 1"),
    MUSegmentItem(title: "Test 2")
]

let line = UIView(frame: .init(x: 0, y: 48, width: 410, height: 2))
line.backgroundColor = .gray

view.addSubview(line)
view.addAutolayoutSubview(segment)

DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
    segment.selectedColor = .orange
    segment.titleColor = .blue
    segment.selectedTitleColor = .black
}

//: [Next](@next)
