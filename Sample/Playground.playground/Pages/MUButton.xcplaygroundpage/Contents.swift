//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

let cornerRadius = CGFloat(4)
let borderWidth = CGFloat(5)

let button = MUButton(frame: CGRect(x: 25, y: 78, width: 150, height: 44))
button.buttonBackgroundColor = UIColor(hex: 0x00171F)
button.title = "SUBMIT"
button.borderColor = UIColor(hex: 0xCD9C0B)
button.progressColor = UIColor(hex: 0xCD9C0B)
button.titleFont = .systemFont(ofSize: 17, weight: .semibold)
button.cornerRadius = cornerRadius
button.borderWidth = borderWidth
button.titleColor = UIColor(hex: 0xCD9C0B)
button.titleHighlightedColor = .white

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    button.state = .disabled
}

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    button.isLoading = true
}

DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
    button.isLoading = false
}

// Second button (using auto layout)

let button2 = MUButton()
button2.buttonBackgroundColor = UIColor(hex: 0x00171F)
button2.backgroundColor = .orange
button2.title = "Let's go to the mall"
button2.titleAlignment = .right
button2.borderColor = UIColor(hex: 0xCD9C0B)
button2.progressColor = UIColor(hex: 0xCD9C0B)
button2.titleFont = .systemFont(ofSize: 17, weight: .semibold)
button2.cornerRadius = cornerRadius * 2.0
button2.borderWidth = borderWidth * 0.5
button2.titleColor = UIColor(hex: 0xCD9C0B)
button2.titleHighlightedColor = .white
button2.horizontalPadding = 32.0

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    button2.title = "TODAY"
    button2.invalidateIntrinsicContentSize()
}

// RightAlign button

let button3 = MUButton(frame: CGRect(x: 25, y: 140, width: 150, height: 44))
button3.buttonBackgroundColor = UIColor(hex: 0x00171F)
button3.title = "LET'S GO"
button3.titleAlignment = .right
button3.borderColor = UIColor(hex: 0xCD9C0B)
button3.progressColor = UIColor(hex: 0xCD9C0B)
button3.titleFont = .systemFont(ofSize: 17, weight: .semibold)
button3.cornerRadius = cornerRadius * 2.0
button3.borderWidth = borderWidth * 0.5
button3.titleColor = UIColor(hex: 0xCD9C0B)
button3.titleHighlightedColor = .white

// Disabled button

let button4 = MUButton(frame: CGRect(x: 25, y: 250, width: 150, height: 44))
button4.buttonBackgroundColor = UIColor.black.withAlphaComponent(0.7)
button4.title = "DISABLED"
//button4.state = .disabled
button4.borderColor = UIColor(hex: 0xCD9C0B, alpha: 0xB2)
button4.titleFont = .systemFont(ofSize: 17, weight: .semibold)
button4.cornerRadius = cornerRadius
button4.borderWidth = 0
button4.titleColor = UIColor(hex: 0xCD9C0B)

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    button4.state = .disabled
}

// Custom loading view

let button5 = MUButton(frame: CGRect(x: 25, y: 310, width: 150, height: 44))
button5.buttonBackgroundColor = .white
button5.title = "LOADING"
button5.borderColor = .orange
button5.titleFont = .systemFont(ofSize: 17, weight: .semibold)
button5.cornerRadius = cornerRadius
button5.borderWidth = 2
button5.titleColor = UIColor(hex: 0xCD9C0B)
button5.progressColor = .green
let indicator = UIActivityIndicatorView(style: .gray)
button5.set(indicator)

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    button5.isLoading = true
    print(indicator)
}

print(indicator.superview)

// ### TEST With fake red button ###

let viewBorder = UIView(frame: CGRect(x: 25, y: 15, width: 150, height: 44))
viewBorder.backgroundColor = .black
viewBorder.layer.borderColor = UIColor.red.cgColor
viewBorder.layer.borderWidth = borderWidth
viewBorder.layer.cornerRadius = cornerRadius

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 440))
view.backgroundColor = .white
view.addSubview(button)
view.addSubview(button2)
view.addSubview(button3)
view.addSubview(button4)
view.addSubview(viewBorder)
view.addSubview(button5)

print(UIColor.clear)
print(UIColor.clear.withAlphaComponent(1.0))

view.centerXAnchor.constraint(equalTo: button2.centerXAnchor).isActive = true
view.centerYAnchor.constraint(equalTo: button2.centerYAnchor).isActive = true

PlaygroundPage.current.liveView = view

//: [Next](@next)
