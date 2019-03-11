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
    @IBOutlet private var topInfoButton: MUButton!
    @IBOutlet private var topWarningButton: MUButton!
    @IBOutlet private var topAlertButton: MUButton!
    @IBOutlet private var bottomInfoButton: MUButton!
    @IBOutlet private var bottomWarningButton: MUButton!
    @IBOutlet private var bottomAlertButton: MUButton!

    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func redToast() -> MUToast {
        let toast = MUToast()
        toast.displayPriority = .alert
        toast.titleColor = .black
        toast.detailColor = .black
        toast.backgroundColor = .red
        toast.icon = #imageLiteral(resourceName: "walkthrough_sleep")
        return toast
    }
}

extension ToastsVC: MUButtonDelegate {
    func didTap(_ button: MUButton) {
        counter += 1

        switch button {
        case topInfoButton:
            let toast = MUToast()
            toast.title = "Title"
            toast.detail = "ID: \(counter) Long description dgfe dfgdfjhgdf fg dfg ffdfg dfgfdg dfgdfgdfjgshl fd fkgdflkgd dfgj dfjg"
            toast.titleColor = .black
            toast.detailColor = .black
            toast.backgroundColor = .green
            toast.cornerRadius = 10.0
            toast.spacing = 0.0
            toast.icon = #imageLiteral(resourceName: "walkthrough_sleep")
            toast.show(in: self)
        case topWarningButton:
            let toast = MUToast()
            toast.displayPriority = .warning
            toast.title = "WARNING"
            toast.detail = "ID: \(counter) Long description dgfe dfgdfjhgdf fg dfg ffdfg dfgfdg dfgdfgdfjgshl fd fkgdflkgd dfgj dfjg"
            toast.titleColor = .black
            toast.detailColor = .black
            toast.backgroundColor = .orange
            toast.cornerRadius = 0.0
            toast.spacing = 2.0
            toast.icon = #imageLiteral(resourceName: "walkthrough_sleep")
            toast.show(in: self)
        case topAlertButton:
            let toast = redToast()
            toast.title = "LONG ALERT TITLE"
            toast.detail = "ID: \(counter) You have to read this now!"
            toast.show(in: self, onTap: {
                print("Tapped")
                toast.hide(completion: { succeed in
                    print("DISSMISSED: Top alert toast succeed:", succeed)
                })
            }, completion: { succeed in
                print("Top alert toast succeed:", succeed)
            })
        case bottomInfoButton:
            let toast = MUToast()
            toast.displayPosition = .bottom
            toast.title = ""
            toast.detail = "ID: \(counter) Small text."
            toast.titleColor = .black
            toast.detailColor = .black
            toast.backgroundColor = .green
            toast.cornerRadius = 10.0
            toast.spacing = 0.0
            toast.icon = #imageLiteral(resourceName: "walkthrough_sleep")
            toast.show(in: self)
        case bottomWarningButton:
            print("TODO")
        case bottomAlertButton:
            let toast = redToast()
            toast.displayPosition = .bottom
            toast.title = "Shutdown in 2 minutes"
            toast.show(in: self)
        default:
            print("INVALID BUTTON")
        }
    }
}
