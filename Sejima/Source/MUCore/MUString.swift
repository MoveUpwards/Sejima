//
//  MUString.swift
//  SejimaTests
//
//  Created by Loïc GRIFFIE on 07/03/2019.
//  Copyright © 2019 Loïc GRIFFIE. All rights reserved.
//

import UIKit

extension String {
    /// Returns bounding box size for a given font
    internal func constrainedSize(width: CGFloat = .greatestFiniteMagnitude,
                                  height: CGFloat = .greatestFiniteMagnitude,
                                  font: UIFont) -> CGSize {
        let rect = CGSize(width: width, height: height)
        return self.boundingRect(with: rect,
                                 options: .usesLineFragmentOrigin,
                                 attributes: [.font: font],
                                 context: nil).size
    }
}
