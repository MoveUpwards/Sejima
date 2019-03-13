//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

let toast = MUToast()
toast.backgroundColor = .orange
toast.cornerRadius = 20.0
toast.icon = UIImage(named: "logo_star")
toast.iconLeftPadding = 4.0
toast.headerVerticalPadding = 20.0
toast.title = "This is a Toast"
toast.titleColor = .green
toast.detail = "Read this before it disappear"
toast.detailColor = .green
toast.headerHorizontalPadding = 4.0

let textToast = MUToast()
textToast.backgroundColor = .orange
textToast.title = "This is a text only Toast"
textToast.titleFont = .systemFont(ofSize: 24, weight: .regular)
textToast.detail = "Read this before it disappear"
textToast.textAlignment = .center

let longToast = MUToast()
longToast.backgroundColor = .red
longToast.title = "This is a long text Toast"
longToast.titleFont = .systemFont(ofSize: 24, weight: .regular)
longToast.detail = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi."
longToast.displayPosition = .bottom

let roundedToast = MUToast()
roundedToast.backgroundColor = .green
roundedToast.cornerRadius = 55.0
roundedToast.title = "This is a long text Toast"
roundedToast.titleFont = .systemFont(ofSize: 24, weight: .regular)
roundedToast.detail = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi."
roundedToast.headerHorizontalPadding = 0.0
roundedToast.headerVerticalPadding = 0.0
roundedToast.displayPosition = .bottom

// Global View

let vc = UIViewController()
vc.view.backgroundColor = .lightGray
vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

toast.show(in: vc)
DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
    textToast.show(in: vc)
}

longToast.show(in: vc)
DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
    roundedToast.show(in: vc)
}

PlaygroundPage.current.liveView = vc

//: [Next](@next)
