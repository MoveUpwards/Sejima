//
//  TBTabController.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 21/01/2021.
//  Copyright © 2021 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
//import Combine

class TBTabController: UIViewController {
    @IBOutlet private var hStack: UIStackView!

    private var items = [TBTabItem]()
    private var selectedItem: Int?

//    @Published var contentView: UIView = UIView()
    @objc dynamic var contentView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        items.enumerated().forEach { index, vc in
            if index == 0 { // Only if items is not empty
                selectedItem = 0
                vc.isSelected = true
                contentView = vc.view
            }
            vc.tapAction = { [weak self] in
                if let selectedIndex = self?.selectedItem {
                    self?.items[selectedIndex].isSelected = false
                }
                self?.selectedItem = index
                self?.items[index].isSelected = true
                self?.contentView = vc.view
            }
            hStack.addArrangedSubview(vc.item)
        }
    }

    func add(_ item: TBTabItem) {
        items.append(item)
    }
}
