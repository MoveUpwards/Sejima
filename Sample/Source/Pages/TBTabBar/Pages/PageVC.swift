//
//  PageVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 25/01/2021.
//  Copyright © 2021 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

enum Pages {
    case red, green, blue, yellow, unknown

    var color: UIColor {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .blue:
            return .blue
        case .yellow:
            return .yellow
        default:
            return .black
        }
    }

    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .red
        case 1:
            self = .green
        case 2:
            self = .blue
        case 3:
            self = .yellow
        default:
            self = .unknown
        }
    }
}

class PageVC: UIViewController, TBTabItem {
    lazy var item: UIView = {
        let itemView = UIView()
        itemView.backgroundColor = page.color

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        itemView.addGestureRecognizer(tap)

        return itemView
    }()

    var isSelected = false {
        didSet {
            guard isSelected else {
                item.backgroundColor = page.color
                return
            }
            item.backgroundColor = .black
        }
    }

    var tapAction: (() -> Void)?

    private var page: Pages = .unknown

    @IBInspectable open var pageRawValue: Int = 0 {
        didSet {
            page = Pages(rawValue: pageRawValue)
        }
    }

    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = page.color
    }

    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) { tapAction?() }
}
