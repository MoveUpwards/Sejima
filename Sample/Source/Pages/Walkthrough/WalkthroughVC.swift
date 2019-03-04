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

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true

        view.clipsToBounds = true // Else scroll view will be visible on page animation

        addScrollViews()

        horizontalPager.pageControl = pageControl

        pageControl.backgroundColor = .clear
        pageControl.pageIndicatorTintColor = UIColor(hex: 0xFA7921, alpha: 0x80)
        pageControl.currentPageIndicatorTintColor = UIColor(hex: 0xFA7921)
        pageControl.enableTouchEvents = true
        pageControl.activeElementWidth = 24
        pageControl.elementSize = CGSize(width: 8, height: 8)
        pageControl.radius = 4

        button.buttonBackgroundColor = .clear
        button.title = "SKIP"
        button.titleFont = .boldSystemFont(ofSize: 17)
        button.titleColor = UIColor(hex: 0xFA7921)
        button.titleHighlightedColor = .white
        button.borderColor = UIColor(hex: 0xFA7921)
        button.borderWidth = 0.0
        button.cornerRadius = button.bounds.height * 0.5
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.addGradient([
            UIColor(hex: 0x094256).cgColor,
            UIColor(hex: 0x00171F).cgColor
        ])
    }

    private func addScrollViews() {
        let vcs = [
            contentView(with: #imageLiteral(resourceName: "walkthrough_bike"),
                        title: "Healthy living",
                        detail: "Simple tips to balance your mind, body & soul")?.view ?? UIView(),
            contentView(with: #imageLiteral(resourceName: "walkthrough_sleep"),
                        title: "Healthy sleep",
                        detail: "Simple tips to balance your mind, body & soul")?.view ?? UIView(),
            contentView(with: #imageLiteral(resourceName: "walkthrough_food"),
                        title: "Fresh food & Water",
                        detail: "Simple tips to balance your mind, body & soul")?.view ?? UIView(),
            contentView(with: #imageLiteral(resourceName: "walkthrough_fitness"),
                        title: "Healthy living",
                        detail: "Simple tips to balance your mind, body & soul")?.view ?? UIView()
        ]

        horizontalPager.add(views: vcs, margin: horizontalPager.horizontalMargin)
    }

    private func contentView(with image: UIImage, title: String = "", detail: String = "") -> WalkthroughContentVC? {
        guard let vc = UIStoryboard(name: "Walkthrough", bundle: nil)
            .instantiateViewController(withIdentifier: "WalkthroughView") as? WalkthroughContentVC else { return nil }

        vc.setup(with: image, title: title, detail: detail)
        return vc
    }
}

extension WalkthroughVC: MUHorizontalPagerDelegate {
    func didScroll(_ horizontalPager: MUHorizontalPager, to index: Int) {
        guard let numberOfPages = horizontalPager.pageControl?.numberOfPages else { return }

        button.title = numberOfPages - 1 == index ? "LET'S GO" : "SKIP"
    }
}

extension WalkthroughVC: MUButtonDelegate {
    func didTap(_ button: MUButton) {
        navigationController?.popViewController(animated: true)
    }
}
