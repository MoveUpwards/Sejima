//
//  TBTabBarVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 21/01/2021.
//  Copyright © 2021 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class TBTabBarVC: UIViewController {
    @IBOutlet private var tabBarBackground: UIView!

    private var tabController: TBTabController?
    private var contentView: UIView?

    var observer: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarBackground.backgroundColor = .lightGray
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let vc = segue.destination as? TBTabController {
            tabController = vc
            if let redVC = UIStoryboard(name: "RedPage", bundle: nil).instantiateInitialViewController() as? TBTabItem {
                tabController?.add(redVC)
            }
            if let greenVC = UIStoryboard(name: "GreenPage", bundle: nil).instantiateInitialViewController() as? TBTabItem {
                tabController?.add(greenVC)
            }
            if let blueVC = UIStoryboard(name: "BluePage", bundle: nil).instantiateInitialViewController() as? TBTabItem {
                tabController?.add(blueVC)
            }
            if let yellowVC = UIStoryboard(name: "YellowPage", bundle: nil).instantiateInitialViewController() as? TBTabItem {
                tabController?.add(yellowVC)
            }

            observer = tabController?.observe(\.contentView, options: [.initial, .new], changeHandler: { [weak self] sender, _ in
                self?.contentView?.subviews.forEach({ subview in
                    subview.removeFromSuperview()
                })
                if let newView = sender.contentView {
                    self?.contentView?.addAutolayoutSubview(newView)
                }
            })
        } else {
            contentView = segue.destination.view
        }
    }
}
