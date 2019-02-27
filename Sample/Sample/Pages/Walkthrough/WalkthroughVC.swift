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

        addScrollViews()
        horizontalPager.pageControl = pageControl
        horizontalPager.horizontalMargin = 20.0

//        pageControl.backgroundColor = .clear
        pageControl.enableTouchEvents = true

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
        horizontalPager.add(views: [v1, v2, v3], offset: 10.0)
    }
}
