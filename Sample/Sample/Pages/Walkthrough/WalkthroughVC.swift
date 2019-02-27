//
//  WalkthroughVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 26/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class WalkthroughVC: UIViewController {
    @IBOutlet private weak var horizontalPager: MUHorizontalPager!
    @IBOutlet private weak var pageControl: MUPageControl!
    @IBOutlet private weak var button: MUButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.clipsToBounds = true // Else scroll view will be visible on page animation

        addScrollViews()
        horizontalPager.pageControl = pageControl
        horizontalPager.horizontalMargin = 20.0

        pageControl.backgroundColor = .clear
        pageControl.tintColors = [.red, .blue, .green, .orange, .lightGray]
        pageControl.currentPageIndicatorTintColor = .purple
        pageControl.enableTouchEvents = true
        pageControl.activeElementWidth = 32
        pageControl.elementSize = CGSize(width: 16, height: 16)
        pageControl.radius = 8
        pageControl.horizontalMargin = 20.0

        button.title = "SKIP"
        button.titleColor = .black
        button.titleHighlightedColor = .lightGray
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    private func addScrollViews() {
        let v1 = UIView()
        v1.backgroundColor = .red
        let v2 = UIView()
        v2.backgroundColor = .blue
        let v3 = UIView()
        v3.backgroundColor = .green
        let v4 = UIView()
        v4.backgroundColor = .orange
        let v5 = UIView()
        v5.backgroundColor = .lightGray
        horizontalPager.add(views: [v1, v2, v3, v4, v5], margin: 10.0)
    }
}
