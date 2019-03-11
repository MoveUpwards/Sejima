//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// ### Global View ###

let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.backgroundColor = .black

PlaygroundPage.current.liveView = view

let progress = MUCircularProgress()
progress.icon = #imageLiteral(resourceName: "gender_male@2x.png")
progress.iconMargin = UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
progress.title = "0 %".uppercased()
progress.titleFont = .systemFont(ofSize: 24, weight: .heavy)
progress.titleColor = .blue
progress.detail = "downloading".uppercased()
progress.detailFont = .systemFont(ofSize: 14, weight: .regular)
progress.detailColor = .orange
progress.trackValue = 1.0
progress.trackLineWidth = 10
progress.trackBackgroundColor = .green
progress.offset = 20
progress.progressLineWidth = 10
progress.progressLineColor = .orange

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    progress.set(value: 0.4, progress: { value in
        progress.title = String(format: "%.2f %%", value)
    })

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        progress.set(value: 0.8)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            progress.set(value: 0.4, animated: false)
        }
    }
}

view.addSubview(progress)
progress.centerXAnchor
    .constraint(equalTo: view.centerXAnchor)
    .isActive = true
progress.centerYAnchor
    .constraint(equalTo: view.centerYAnchor)
    .isActive = true

//: [Next](@next)
