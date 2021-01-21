//
//  TBTabController.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 21/01/2021.
//  Copyright © 2021 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
//import Sejima

class TBTabController: UIViewController {
    @IBOutlet private var hStack: UIStackView!

    private var items = [TBTabItem]()
    private var selectedItem: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
    }

    func add(_ item: TBTabItem) {
        items.append(item)
        hStack.addArrangedSubview(item.view)
        if selectedItem == nil { selectedItem = 0 }
    }
}
