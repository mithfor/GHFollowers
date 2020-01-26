//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 14.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    let headerView   = UIView()
    let itemViewOne  = UIView()
    let itemViewTwo  = UIView()
    var itemViews: [UIView] = []
    
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
    }
}

private extension UserInfoViewController {
    func layoutUI() {
        
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        itemViews.forEach { aView in
            view.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                aView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
                aView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: Constants.itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: Constants.padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: Constants.itemHeight),
        ])
    }
    
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = donebutton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                    self.add(childViewController: GFRepoItemViewController(user: user), to: self.itemViewOne)
                    self.add(childViewController: GFFollowerItemViewController(user: user), to: self.itemViewTwo)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

private extension UserInfoViewController {
    enum Constants {
        static let headerViewHeight: CGFloat = 180
        static let padding: CGFloat = 20
        static let itemHeight: CGFloat = 140
        
    }
}
