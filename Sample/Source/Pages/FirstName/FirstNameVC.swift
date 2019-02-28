//
//  FirstNameVC.swift
//  MUSample
//
//  Created by Damien Noël Dubuisson on 25/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class FirstNameVC: UIViewController {
    @IBOutlet private weak var topBar: MUTopBar!
    @IBOutlet private weak var header: MUHeader!
    @IBOutlet private weak var textfield: MUTextField!
    @IBOutlet private weak var button: MUButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        topBar.delegate = self
        button.delegate = self
    }
}

extension FirstNameVC: MUTopBarDelegate {
    func didTap(_ topBar: MUTopBar) {
        navigationController?.popViewController(animated: true)
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
