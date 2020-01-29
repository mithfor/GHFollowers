//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 04.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersitenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }

}
