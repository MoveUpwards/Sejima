//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 600))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Delegate class ###

final class MyDelegate: MUStatDelegate {
    func didTap(stat: MUStat) {
        print(stat)
    }
}

let delegate = MyDelegate()

// ### Empty one ###

let emptyStat = MUStat()
emptyStat.backgroundColor = .lightGray
emptyStat.showVerticalSeparator = false
emptyStat.verticalSeparatorWidth = 16
emptyStat.verticalPadding = 2.0

view.addSubview(emptyStat)
emptyStat.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
emptyStat.topAnchor
    .constraint(equalTo: view.topAnchor, constant: 20.0)
    .isActive = true

// ### text only ###

let textStat = MUStat()
textStat.backgroundColor = .lightGray
textStat.valueColor = .white
textStat.unitColor = .orange
textStat.detailColor = .gray
textStat.valueFont = .systemFont(ofSize: 32, weight: .regular)
textStat.unitFont = .systemFont(ofSize: 13, weight: .regular)
textStat.detailFont = .systemFont(ofSize: 11, weight: .semibold)
textStat.format = "%.1f"
textStat.value = 4.2
textStat.unit = "km/h"
textStat.detail = "average speed"
textStat.showVerticalSeparator = false
textStat.horizontalSeparatorColor = .orange
textStat.horizontalSeparatorHeight = 3
textStat.textVerticalPadding = 50
textStat.horizontalSeparatorWidth = 30
textStat.textAlignment = .right
textStat.delegate = delegate

view.addSubview(textStat)
textStat.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
textStat.topAnchor
    .constraint(equalTo: emptyStat.bottomAnchor, constant: 20.0)
    .isActive = true

// ### with separator ###

let separatorStat = MUStat()
separatorStat.verticalPadding = 0.0
separatorStat.backgroundColor = .lightGray
separatorStat.valueColor = .white
separatorStat.unitColor = .orange
separatorStat.detailColor = .gray
separatorStat.valueFont = .systemFont(ofSize: 32, weight: .regular)
separatorStat.unitFont = .systemFont(ofSize: 13, weight: .regular)
separatorStat.detailFont = .systemFont(ofSize: 11, weight: .semibold)
separatorStat.format = "%.1f"
separatorStat.value = 4.2
separatorStat.unit = "km/h"
separatorStat.detail = "average speed"
separatorStat.verticalSeparatorLeftPadding = 8
separatorStat.showVerticalSeparator = true
separatorStat.verticalSeparatorColor = .green
separatorStat.verticalSeparatorWidth = 5
separatorStat.horizontalSeparatorHeight = 0
view.addSubview(separatorStat)
separatorStat.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
separatorStat.topAnchor
    .constraint(equalTo: textStat.bottomAnchor, constant: 20.0)
    .isActive = true

// ### with icon ###

let iconStat = MUStat()
iconStat.verticalPadding = 0.0
iconStat.backgroundColor = .lightGray
iconStat.valueColor = .white
iconStat.unitColor = .orange
iconStat.detailColor = .gray
iconStat.valueFont = .systemFont(ofSize: 24, weight: .regular)
iconStat.unitFont = .systemFont(ofSize: 13, weight: .regular)
iconStat.detailFont = .systemFont(ofSize: 11, weight: .semibold)
iconStat.format = "%.1f"
iconStat.value = 4.2
iconStat.unit = "km/h"
iconStat.detail = "average speed"
iconStat.showVerticalSeparator = false
iconStat.horizontalSeparatorHeight = 2
iconStat.horizontalSeparatorColor = .green
iconStat.horizontalSeparatorHeight = 5
iconStat.horizontalSeparatorWidth = 50
iconStat.icon = UIImage(named: "icon")

view.addSubview(iconStat)
iconStat.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
iconStat.topAnchor
    .constraint(equalTo: separatorStat.bottomAnchor, constant: 20.0)
    .isActive = true

// ### Full stat ###

let fullStat = MUStat()
fullStat.verticalPadding = 0.0
fullStat.backgroundColor = .lightGray
fullStat.valueColor = .white
fullStat.unitColor = .orange
fullStat.detailColor = .gray
fullStat.valueFont = .systemFont(ofSize: 24, weight: .regular)
fullStat.unitFont = .systemFont(ofSize: 13, weight: .regular)
fullStat.detailFont = .systemFont(ofSize: 11, weight: .semibold)
fullStat.format = "%.1f"
fullStat.value = 4.2
fullStat.unit = "km/h"
fullStat.detail = "average speed"
fullStat.showVerticalSeparator = true
fullStat.verticalSeparatorColor = .green
fullStat.verticalSeparatorWidth = 5
fullStat.verticalSeparatorLeftPadding = 0
fullStat.horizontalSeparatorHeight = 0
fullStat.iconLeftPadding = 0
fullStat.icon = UIImage(named: "icon")

view.addSubview(fullStat)
fullStat.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
fullStat.topAnchor
    .constraint(equalTo: iconStat.bottomAnchor, constant: 20.0)
    .isActive = true

// ### Full multiline stat ###

let multilineStat = MUStat()
multilineStat.verticalPadding = 8.0
multilineStat.backgroundColor = .lightGray
multilineStat.valueColor = .white
multilineStat.unitColor = .orange
multilineStat.detailColor = .gray
multilineStat.valueFont = .systemFont(ofSize: 24, weight: .regular)
multilineStat.unitFont = .systemFont(ofSize: 13, weight: .regular)
multilineStat.detailFont = .systemFont(ofSize: 18, weight: .semibold)
multilineStat.format = "%.1f"
multilineStat.value = 4.2
multilineStat.unit = "km/h"
multilineStat.detail = "average speed"
multilineStat.showVerticalSeparator = true
multilineStat.verticalSeparatorColor = .green
multilineStat.verticalSeparatorWidth = 5
multilineStat.verticalSeparatorLeftPadding = 8
multilineStat.horizontalSeparatorHeight = 0
multilineStat.iconLeftPadding = 8
multilineStat.icon = UIImage(named: "icon")
multilineStat.iconWidth = 60.0

view.addSubview(multilineStat)
multilineStat.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
multilineStat.widthAnchor
    .constraint(equalToConstant: 150.0)
    .isActive = true
multilineStat.topAnchor
    .constraint(equalTo: fullStat.bottomAnchor, constant: 20.0)
    .isActive = true

//: [Next](@next)
