//
//  ButtonVC.swift
//  MUSample
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import MUComponent

class UIAppearenceFakeView: UIView {
    // Put MUComponent in an UIAppearenceFakeView to use UIAppearence configuration
}

class Button: UIViewController {
    @IBOutlet private weak var frameButton: MUButton!
    @IBOutlet private weak var autolayoutButton: MUButton!

    @IBOutlet private weak var leftActivateButton: MUButton!
    @IBOutlet private weak var rightActivateButton: MUButton!

    @IBOutlet private weak var loadingButton: MUButton!
    @IBOutlet private weak var alignRightButton: MUButton!

    // See AppDelegate.swift
    @IBOutlet private weak var uiAppearenceButton: MUButton!
    // See Button.storyboard -> Show the Attributes inspector
    @IBOutlet private weak var storyboardButton: MUButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = type(of: self).description().components(separatedBy: ".").last

        for item in [frameButton, autolayoutButton] {
            item?.buttonBackgroundColor = UIColor(hex: 0x00171F)
            item?.title = "SUBMIT"
            item?.borderColor = UIColor(hex: 0xCD9C0B)
            item?.progressColor = UIColor(hex: 0xCD9C0B)
            item?.titleFont = .systemFont(ofSize: 17.0, weight: .light)
            item?.cornerRadius = 4.0
            item?.borderWidth = 4.0
            item?.titleColor = UIColor(hex: 0xCD9C0B)
            item?.titleHighlightedColor = .white
        }

        for item in [leftActivateButton, rightActivateButton] {
            item?.buttonBackgroundColor = UIColor(hex: 0x00171F)
            item?.backgroundColor = .orange
            item?.title = "Let's go to the mall"
            item?.titleAlignment = .right
            item?.borderColor = UIColor(hex: 0xCD9C0B)
            item?.progressColor = UIColor(hex: 0xCD9C0B)
            item?.titleFont = .systemFont(ofSize: 17, weight: .semibold)
            item?.cornerRadius = 8.0
            item?.borderWidth = 2.0
            item?.verticalPadding = 4.0
            item?.horizontalPadding = 20.0
            item?.titleColor = UIColor(hex: 0xCD9C0B)
            item?.titleHighlightedColor = .white
            item?.delegate = self
        }
        leftActivateButton.title = "Click me to activate right"
        rightActivateButton.title = "OFF"
        rightActivateButton.state = .disabled

        for item in [loadingButton, alignRightButton] {
            item?.buttonBackgroundColor = UIColor(hex: 0x00171F)
            item?.title = "DONE"
            item?.borderColor = UIColor(hex: 0xCD9C0B)
            item?.progressColor = UIColor(hex: 0xCD9C0B)
            item?.titleFont = .systemFont(ofSize: 17, weight: .semibold)
            item?.cornerRadius = 16.0
            item?.borderWidth = 1.0
            item?.titleColor = UIColor(hex: 0xCD9C0B)
            item?.titleHighlightedColor = .white
        }
        loadingButton.isLoading = true
        loadingButton.delegate = self
        alignRightButton.titleAlignment = .right

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.loadingButton.isLoading = false
        }

        uiAppearenceButton.title = "UIAppearence"
    }
}

extension Button: MUButtonDelegate {
    func didTap(_ button: MUButton) {
        switch button {
        case leftActivateButton:
            leftActivateButton.title = "OFF"
            leftActivateButton.state = .disabled
            rightActivateButton.title = "Click me to activate left"
            rightActivateButton.state = .normal
        case rightActivateButton:
            leftActivateButton.title = "Click me to activate right"
            leftActivateButton.state = .normal
            rightActivateButton.title = "OFF"
            rightActivateButton.state = .disabled
        case loadingButton:
            loadingButton.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.loadingButton.isLoading = false
            }
        default:
            break
        }
    }
}
