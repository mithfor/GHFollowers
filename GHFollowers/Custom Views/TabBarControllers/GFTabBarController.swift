//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 01.02.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        
        viewControllers          = [createSearchNavigationController(), createFavoritesNavigationController()]

    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: .zero)
        
        return UINavigationController(rootViewController: searchVC)
    }

    
    func createFavoritesNavigationController() -> UINavigationController {
        let favoritesListVC = FavoritesListViewController()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
}
