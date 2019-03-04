//
//  WalkthroughContentVC.swift
//  Sample
//
//  Created by Loïc GRIFFIE on 27/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class WalkthroughContentVC: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var header: MUHeader!

    private var image: UIImage?
    private var headerTitle: String = ""
    private var headerDetail: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear

        header.backgroundColor = .clear
        header.titleFont = .boldSystemFont(ofSize: 24)
        header.titleColor = .white
        header.title = headerTitle
        header.detailFont = .systemFont(ofSize: 14)
        header.detailColor = .white
        header.detail = headerDetail
        header.textAlignment = .center

        imageView.backgroundColor = .clear
        imageView.image = image
    }

    internal func setup(with image: UIImage, title: String, detail: String) {
        self.image = image

        headerTitle = title
        headerDetail = detail
    }
}
