//
//  CircularIndicatorVC.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 05/03/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit
import Sejima

class CircularIndicatorVC: UIViewController {
    @IBOutlet private var progress: MUCircularIndicator!

    override func viewDidLoad() {
        super.viewDidLoad()

        progress.progressShapeColor = .blue
        progress.backgroundShapeColor = .yellow
        progress.titleColor = .red
        progress.titleVerticalInset = 20
        progress.percentColor = .black
        progress.percentVerticalInset = -60
        progress.orientation = .top

        progress.lineWidth = 10
        progress.lineCap = .round

        progress.title = "Title"
        progress.percentLabelFormat = "%.2f%%"
        progress.completeDuration = 0.25
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        progress.set(value: 0.5, animated: true)
    }
}

extension UIView {
    func asImage() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(frame.size)

            guard let context = UIGraphicsGetCurrentContext() else { return nil }

            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            guard let renderedImage = image?.cgImage else { return nil }

            return UIImage(cgImage: renderedImage)
        }
    }
}

