//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 05.02.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

extension UITableView {
    
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
