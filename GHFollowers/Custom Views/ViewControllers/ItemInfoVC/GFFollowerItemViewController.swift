//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 26.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class GFFollowerItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
}

private extension GFFollowerItemViewController {
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user?.followers ?? .zero)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user?.following ?? .zero)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
