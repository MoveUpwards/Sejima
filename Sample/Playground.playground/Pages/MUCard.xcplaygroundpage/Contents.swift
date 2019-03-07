//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

// ### Card autolayout ###

let card = MUCard()
card.topPadding = 24
card.contentLeftPadding = 24
card.contentRightPadding = 24
card.contentTopPadding = 24
card.contentBottomPadding = 24
card.backgroundColor = .gray
card.style = .custom(20)
card.borderWidth = 4
card.borderColor = .white
card.textAlignment = .left
card.headerHorizontalPadding = 24
card.title = "My tag"
card.titleFont = .systemFont(ofSize: 34, weight: .regular)
card.titleColor = .black
card.detail = "My dummy information text"
card.detailFont = .systemFont(ofSize: 14, weight: .light)
card.detailColor = .darkText

let fake = UIView()
fake.backgroundColor = .orange
card.add(contentView: fake)

view.addSubview(card)
card.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
card.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true
card.widthAnchor
    .constraint(equalTo: view.widthAnchor)
    .isActive = true
card.heightAnchor
    .constraint(equalTo: view.heightAnchor)
    .isActive = true

//: [Next](@next)
