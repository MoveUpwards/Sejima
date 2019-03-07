//
//  MUImage.swift
//  Sejima
//
//  Created by Loïc GRIFFIE on 07/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

extension UIImage {
    internal convenience init?(histogram: [CGFloat], bar: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }

        guard let context = UIGraphicsGetCurrentContext(), let maxValue = histogram.max() else {
            return nil
        }

        let barWidth = size.width / CGFloat(histogram.count + histogram.count - 1)
        var currentX = CGFloat(0.0)
        context.setAllowsAntialiasing(false)
        context.setFillColor(bar.cgColor)

        histogram.forEach { value in
            let height = value / maxValue * size.height
            let rect = CGRect(x: currentX, y: size.height - height, width: barWidth, height: height)
            context.fill(rect)

            currentX += barWidth * 2.0
        }

        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }

        self.init(cgImage: cgImage)
    }
}
