//
//  FirstNameVC.swift
//  MUSample
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import MUComponent

class FirstNameVC: UIViewController {
    @IBOutlet private weak var header: MUHeader!
    @IBOutlet private weak var textfield: MUTextField!
    @IBOutlet private weak var button: MUButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        button.delegate = self
    }
}

extension FirstNameVC: MUButtonDelegate {
    func didTap(_ button: MUButton) {
        button.isLoading = true
        print("Your firstname is:", textfield.text)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            button.isLoading = false
        }
    }
}
