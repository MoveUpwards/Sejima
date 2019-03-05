//
//  ToastsVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class ToastsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ToastsVC: MUButtonDelegate {
    func didTap(_ button: MUButton) {
        let toast = MUToast()
        toast.title = "Title"
        toast.detail = "Long description dgfe dfgdfjhgdf fg dfg ffdfg dfgfdg dfgdfgdfjgshl fd fkgdflkgd dfgj dfjg"
        toast.titleColor = .black
        toast.detailColor = .black
        toast.backgroundColor = .green
        toast.cornerRadius = 10.0
        toast.spacing = 0.0
        toast.show(in: self)
    }
}
