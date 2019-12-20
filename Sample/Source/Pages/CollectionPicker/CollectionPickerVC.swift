//
//  CollectionPickerVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class CollectionPickerVC: UIViewController {
    @IBOutlet private var picker: MUCollectionPicker!

    override func awakeFromNib() {
        super.awakeFromNib()

        MUCollectionPicker.appearance().itemSelectedColor = .white
        MUCollectionPicker.appearance().itemUnselectedColor = .orange
        MUCollectionPicker.appearance().indicatorColor = .green
        MUCollectionPicker.appearance().indicatorWidth = 2.0
        MUCollectionPicker.appearance().indicatorHeight = 2.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.set(["2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010"])
    }
}

extension CollectionPickerVC: MUCollectionPickerDelegate {
    func size(_ picker: MUCollectionPicker, at indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 50)
    }
    
    func didSelect(item: String, at index: Int) {
        print("item: \(item), index: \(index)")
    }
}
