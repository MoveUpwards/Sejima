//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 410, height: 80))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### TopBar with autolayout ###

let topBar = MUTopBar()
topBar.backgroundColor = .green
topBar.lineNumber = 0
topBar.titleVerticalAlignment = .top
topBar.buttonAlignment = .leading
topBar.buttonLeftPadding = 24
topBar.showButton = true
topBar.title = "TopBar with autolayout, TopBar with autolayout, TopBar with autolayout, TopBar with autolayout, TopBar with autolayout"

view.addAutolayoutSubview(topBar)

//: [Next](@next)
