//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 04.02.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
