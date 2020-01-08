//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 07.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
}
