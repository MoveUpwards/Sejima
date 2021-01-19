//
//  MUNibView.swift
//  Sejima
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import Neumann
import UIKit

/// An object that manages the content for a rectangular area on the screen from a xib file.
open class MUNibView: NibView {
    open override var bundle: Bundle {
        Bundle.module
    }
}
