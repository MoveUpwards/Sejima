//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

let trimmer = MURangeTrimmer()
trimmer.backgroundColor = .lightGray
trimmer.borderColor = .orange
trimmer.borderWidth = 4.0

let splitTrimmer = MURangeTrimmer()
splitTrimmer.backgroundColor = .lightGray
splitTrimmer.borderColor = .orange
splitTrimmer.borderWidth = 4.0
splitTrimmer.ranges = [(range: MURange<CGFloat>(location: 5.0, length: 40.0), title: "First half"),
                       (range: MURange<CGFloat>(location: 55.0, length: 40.0), title: "Second Half")]

// Global view

let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 215))
view.backgroundColor = .red
view.addSubview(trimmer)
view.addSubview(splitTrimmer)

trimmer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.0).isActive = true
trimmer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.0).isActive = true
trimmer.topAnchor.constraint(equalTo: view.topAnchor, constant: 5.0).isActive = true
trimmer.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

splitTrimmer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.0).isActive = true
splitTrimmer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.0).isActive = true
splitTrimmer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0).isActive = true
splitTrimmer.heightAnchor.constraint(equalToConstant: 100.0).isActive = true

PlaygroundPage.current.liveView = view

//: [Next](@next)
