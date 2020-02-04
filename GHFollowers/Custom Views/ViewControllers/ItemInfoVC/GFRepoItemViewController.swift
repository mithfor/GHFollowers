//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 26.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

protocol GFRepoItemViewControllerDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemViewController: GFItemInfoViewController {

    weak var delegate: GFRepoItemViewControllerDelegate!
    
    init(user: User, delegate: GFRepoItemViewControllerDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureItems()
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user!)
    }
}

private extension GFRepoItemViewController {
    func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user?.publicRepos ?? .zero)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user?.publicGists ?? .zero)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
