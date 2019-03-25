//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import Sejima

// Define UITabBarItems

let houseImage = UIImage(named: "home")
let chartImage = UIImage(named: "chart-bar")
let calendarImage = UIImage(named: "calendar")
let clipboardImage = UIImage(named: "clipboard-list")
let items = [UITabBarItem(title: nil, image: houseImage, selectedImage: houseImage), UITabBarItem(title: nil, image: chartImage, selectedImage: chartImage), UITabBarItem(title: nil, image: calendarImage, selectedImage: calendarImage), UITabBarItem(title: "More", image: clipboardImage, selectedImage: clipboardImage)]

// Define the custom UITabBar

let tabBar = MUTabBar()
tabBar.backgroundColor = .orange
tabBar.selectedColor = UIColor(red: 0.80, green: 0.61, blue: 0.04, alpha: 1)
tabBar.unselectedColor = UIColor(red: 0.86, green: 0.89, blue: 0.92, alpha: 0.5)
tabBar.separatorColor = UIColor(red: 0.86, green: 0.89, blue: 0.92, alpha: 0.5)
tabBar.separatorHeight = 4.0
tabBar.items = items
tabBar.select(at: 0)

let vc = UIViewController()
vc.view.backgroundColor = .white
vc.view.frame = CGRect(x: 0, y: 0, width: 375, height: 667)
vc.view.addSubview(tabBar)

tabBar.translatesAutoresizingMaskIntoConstraints = false
tabBar.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor).isActive = true
tabBar.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor).isActive = true
tabBar.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor).isActive = true
tabBar.heightAnchor.constraint(equalTo: vc.view.heightAnchor, multiplier: 0.07).isActive = true

PlaygroundPage.current.liveView = vc.view

//: [Next](@next)
