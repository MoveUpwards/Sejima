//
//  TabBarVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 21/01/2021.
//  Copyright © 2021 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class TabBarVC: UIViewController {
    @IBOutlet private var tabBar: MUTabBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .lightGray
        tabBar.setItems([UITabBarItem(title: "One", image: UIImage(named: "back"), selectedImage: UIImage(named: "Logo")),
                         UITabBarItem(title: "Two", image: UIImage(named: "back"), selectedImage: UIImage(named: "Logo")),
                         UITabBarItem(title: "Three", image: UIImage(named: "back"), selectedImage: UIImage(named: "Logo"))],
                        animated: true)
//        tabBar.items = [UITabBarItem(title: "One", image: UIImage(named: "back"), selectedImage: UIImage(named: "Logo"))]
    }
}
