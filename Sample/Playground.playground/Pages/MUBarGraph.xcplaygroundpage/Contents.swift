//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

let datas = [MUBarGraphData(title: "MON", value: 0.1, color: .blue),
             MUBarGraphData(title: "TUE", value: 0.2, color: .red),
             MUBarGraphData(title: "WED", value: 0.7, color: .green),
             MUBarGraphData(title: "THU", value: 0.99, color: .lightGray),
             MUBarGraphData(title: "FRI", value: 0.1, color: .purple),
             MUBarGraphData(title: "SAT", value: 0.5, color: .cyan),
             MUBarGraphData(title: "SUN", value: 0.3, color: .yellow, showIndicator: true)]
let values = ["0", "300m", "600m", "900m", "1.2km", "1.5km"]

let graph = MUBarGraph(frame: CGRect(origin: CGPoint(x: 10, y: 5), size: CGSize(width: 307, height: 168)))
graph.backgroundColor = .white
graph.titleColor = .black
graph.barWidth = 0.2
graph.datas = datas
graph.values = values

let bigGraph = MUBarGraph(frame: CGRect(origin: CGPoint(x: 10, y: 180), size: CGSize(width: 614, height: 336)))
bigGraph.datas = datas
bigGraph.values = values
bigGraph.backgroundColor = UIColor.white.withAlphaComponent(0.5)
bigGraph.titleFont = .systemFont(ofSize: 12.0, weight: .regular)
bigGraph.titleColor = .black
bigGraph.titleTopInset = 10.0
bigGraph.valueRightInset = 10.0
bigGraph.barWidth = 0.2
bigGraph.barTopInset = 40.0
bigGraph.lineWidth = 2.0
bigGraph.lineColor = UIColor.black.withAlphaComponent(0.2)
bigGraph.indicatorTextFont = .systemFont(ofSize: 22.0, weight: .bold)
bigGraph.indicatorTextColor = .lightGray
bigGraph.indicatorWidth = 0.5
bigGraph.indicatorColor = .darkGray
bigGraph.indicatorMultiplier = 1500
bigGraph.indicatorFormat = "%.fm"

// ### Global View ###

let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 630, height: 520)))
view.backgroundColor = .orange
view.addSubview(graph)
view.addSubview(bigGraph)

PlaygroundPage.current.liveView = view

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    graph.datas = [MUBarGraphData(title: "MON\nDAY", value: 0.1, color: .blue),
                   MUBarGraphData(title: "TUE", value: 0.2, color: .red)]
}

//: [Next](@next)
