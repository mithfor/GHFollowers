//
//  FavoritesListViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 04.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class FavoritesListViewController: GFDataLoadingViewController {

    let tableView               = UITableView()
    var favorites: [Follower]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewContoller()
        confirureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorities()
    }
    
    func configureViewContoller() {
        view.backgroundColor = .systemBackground
        title = "Favorities"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func confirureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    func getFavorities() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self?.showEmptySpaceView(with: "No favorities? \nAddfucking one on the follower screen", in: self?.view ?? UIView())
                } else {
                    self?.favorites = favorites
                    self?.tableView.reloadDataOnMainThread()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                        self?.view.bringSubviewToFront(self?.tableView ?? UITableView())
                    }
                }
                self?.favorites = favorites
            case .failure(let error):
                self?.presentGFAlertOnMainThread(title: "Somethings went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}


extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as? FavoriteCell {
            let favorite = favorites[indexPath.row]
            
            cell.set(favorite: favorite)
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        
        let destVC = FollowerListViewController(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let error = error else {
                self?.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self?.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
