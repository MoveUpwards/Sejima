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
    @IBOutlet private var topButton: MUButton!
    @IBOutlet private var bottomButton: MUButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension ToastsVC: MUButtonDelegate {
    func didTap(_ button: MUButton) {
        switch button {
        case topButton:
            let toast = MUToast()
            toast.title = "Title"
            toast.detail = "Long description dgfe dfgdfjhgdf fg dfg ffdfg dfgfdg dfgdfgdfjgshl fd fkgdflkgd dfgj dfjg"
            toast.titleColor = .black
            toast.detailColor = .black
            toast.backgroundColor = .green
            toast.cornerRadius = 10.0
            toast.spacing = 0.0
            toast.icon = #imageLiteral(resourceName: "walkthrough_sleep")
            toast.show(in: self)
        case bottomButton:
            let toast = MUToast()
            toast.displayPosition = .bottom
            toast.title = "Title"
            toast.detail = "Long description dgfe dfgdfjhgdf fg dfg ffdfg dfgfdg dfgdfgdfjgshl fd fkgdflkgd dfgj dfjg"
            toast.titleColor = .black
            toast.detailColor = .black
            toast.backgroundColor = .green
            toast.cornerRadius = 10.0
            toast.spacing = 0.0
            toast.icon = #imageLiteral(resourceName: "walkthrough_sleep")
            toast.show(in: self)
        default:
            print("INVALID BUTTON")
        }
    }
}
