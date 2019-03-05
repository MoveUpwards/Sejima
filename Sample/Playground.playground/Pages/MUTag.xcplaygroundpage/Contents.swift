//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

class MUTag: MUButton {
    override var isUserInteractionEnabled: Bool {
        get {
            return false
        }
        set { }
    }

    override var nibName: String? {
        return "MUButton"
    }

    override var bundle: Bundle? {
        return Bundle(for: MUButton.self)
    }
}

// ### Align left header with autolayout ###

var tags = [MUTag]()
let titles = ["swift", "development", "framework"]
for title in titles {
    let tag = MUTag()
    tag.title = title.uppercased()
    tag.titleFont = .boldSystemFont(ofSize: 12)
    tag.titleColor = .white
    tag.cornerRadius = 4
    tag.buttonBackgroundColor = .orange
    tag.horizontalPadding = 8
    tag.verticalPadding = 4
    tags.append(tag)
}

for tag in tags {
    guard let idx = tags.index(of: tag) else { continue }

    view.addSubview(tag)
    if idx == 0 {
        tag.leadingAnchor
            .constraint(equalTo: view.leadingAnchor, constant: 8)
            .isActive = true
    } else {
        let previous = tags[(idx - 1)]
        tag.leadingAnchor
            .constraint(equalTo: previous.trailingAnchor, constant: 8)
            .isActive = true
    }

    tag.centerYAnchor
        .constraint(equalTo: view.centerYAnchor)
        .isActive = true
}

//: [Next](@next)
