//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 14.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoViewController: UIViewController {

    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowersListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
    }
}

private extension UserInfoViewController {
    func layoutUI() {
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
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
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: Constants.padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
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
                    self.configureUIElements(with: user)
                    
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        
        let repoItemVC = GFRepoItemViewController(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemViewController(user: user)
        followerItemVC.delegate = self
        
        self.add(childViewController: repoItemVC, to: self.itemViewOne)
        self.add(childViewController: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
}

extension UserInfoViewController: UserInfoViewControllerDelegate {
    
    
    func didTapGitHubProfile(for user: User) {

        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariViewController(with: url)
    }
    
    
    func didTapGetFollowers(for user: User) {
        print(#function)
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title:"No followers", message: "This user has no followers. What a shame 😞.", buttonTitle: "So sad")
            return
        }
        delegate?.didRequestUser(for: user.login)
        dismissVC()
    }

}

private extension UserInfoViewController {
    enum Constants {
        static let headerViewHeight: CGFloat = 180
        static let padding: CGFloat = 20
        static let itemHeight: CGFloat = 140
    }
}
