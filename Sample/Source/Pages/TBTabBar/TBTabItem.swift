//
//  TBTabItem.swift
//  Sample
//
//  Created by Damien Noël Dubuisson on 21/01/2021.
//  Copyright © 2021 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

public protocol TBTabItem: UIViewController {
    var item: UIView { get }
    var selectedItem: UIView { get }
}
