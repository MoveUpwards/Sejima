//
//  TBTabBarVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 21/01/2021.
//  Copyright © 2021 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
//import Sejima

class TBTabBarVC: UIViewController {
    private var tabController: TBTabController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let vc = segue.destination as? TBTabController {
            tabController = vc
        } else if let vc = segue.destination as? TBTabItem {
            tabController?.add(vc)
        }
    }
}
