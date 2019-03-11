//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

let spider = MURadarGraph(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
spider.backgroundColor = .white
spider.spokeTitles = ["One", "Two", "Three"]
spider.spokeLineThickness = 0.25
spider.spokeLineColor = .cyan
spider.spokeTitleColor = .darkGray
spider.dotRadius = 2.0
spider.dotLineThickness = 0.25
spider.backgroundLines = [MURadarGraphBackgroundLine(fillColor: UIColor(red: 0.040, green: 0.238, blue: 0.309, alpha: 1), strokeColor: .clear),
                          MURadarGraphBackgroundLine(fillColor: UIColor(red: 0.020, green: 0.176, blue: 0.231, alpha: 1), strokeColor: .clear),
                          MURadarGraphBackgroundLine(fillColor: UIColor(red: 0.000, green: 0.114, blue: 0.153, alpha: 1), strokeColor: .clear)]

let dataOne = MURadarGraphData(values: [1.00, 0.50, 1.00, 0.75, 0.75, 0.75],
                               color: UIColor(red: 0.15, green: 0.38, blue: 0.64, alpha: 1))
let dataTwo = MURadarGraphData(values: [0.33, 0.70, 0.80, 0.25, 0.55, 0.35],
                               color: UIColor(red: 0.64, green: 0.38, blue: 0.15, alpha: 1))

view.addSubview(spider)

spider.addChart(data: dataOne,
                duration: 0.75,
                delay: 3.0,
                completion: { _ in
                    spider.addChart(data: dataTwo,
                                    duration: 0.75,
                                    delay: 0.25,
                                    completion: { _ in })
})

//: [Next](@next)
