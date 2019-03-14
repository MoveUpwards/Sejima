//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

let histogram = MUHistogram()
histogram.backgroundColor = .lightGray
histogram.values = [0.5, 1.0, 2.0, 1.0, 4.0, 1.0, 2.0, 1.0, 3.0, 0.5, 1.0, 5.0, 4.0]

let histoData = (0..<70).map{ _ in CGFloat.random(in: 0 ... 5) }

let histogram2 = MUHistogram()
histogram2.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
histogram2.barColor = .blue
histogram2.contentHorizontalPadding = 4.0
histogram2.contentVerticalPadding = 4.0
histogram2.layer.cornerRadius = 4.0
histogram2.layer.borderWidth = 1.0
histogram2.layer.borderColor = UIColor.black.cgColor
histogram2.values = histoData

let histogram2Value = MUHistogram()
histogram2Value.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
histogram2Value.barColor = .blue
histogram2Value.contentHorizontalPadding = 2.0
histogram2Value.contentVerticalPadding = 6.0
histogram2Value.layer.cornerRadius = 4.0
histogram2Value.layer.borderWidth = 1.0
histogram2Value.layer.borderColor = UIColor.black.cgColor
histogram2Value.values = histoData

let histogram3 = MUHistogram()
histogram3.backgroundColor = .lightGray
histogram3.barColor = .green
histogram3.values = [1.2, 2.4, 0.5, 3.6, 0.7, 2.0, 1.1, 2.4, 0.2, 3.0, 0.7, 1.9, 4.1, 1.0, 0.4, 3.6, 0.7, 2.0, 1.1, 4.8, 3.6, 0.7, 2.0, 1.1, 1.4, 2.0, 1.0, 1.9, 4.1, 2.4, 0.1, 3.0, 0.7, 1.9, 4.1, 5.0]

// Global view

let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 410))
view.backgroundColor = .white
view.addSubview(histogram)
view.addSubview(histogram2)
view.addSubview(histogram2Value)
view.addSubview(histogram3)

histogram.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
histogram.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
histogram.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
histogram.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0).isActive = true

histogram2.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
histogram2.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
histogram2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
histogram2.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -55.0).isActive = true

histogram2Value.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
histogram2Value.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
histogram2Value.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
histogram2Value.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 55.0).isActive = true

histogram3.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
histogram3.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
histogram3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
histogram3.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10.0).isActive = true

PlaygroundPage.current.liveView = view

//: [Next](@next)
