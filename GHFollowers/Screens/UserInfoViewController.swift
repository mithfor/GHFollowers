//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 14.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = donebutton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
