//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 26.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class GFRepoItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
}

private extension GFRepoItemViewController {
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user?.publicRepos ?? .zero)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user?.publicGists ?? .zero)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
