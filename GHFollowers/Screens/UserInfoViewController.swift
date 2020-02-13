//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 14.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
    func didRequestUser(for username: String)
}

class UserInfoViewController: UIViewController {
    
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
}

    // MARK: - Private methods

private extension UserInfoViewController {
    func layoutUI() {
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        itemViews.forEach { aView in
            contentView.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                aView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
                aView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Constants.padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: Constants.itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: Constants.padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: Constants.itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: Constants.padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
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
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
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
        
        self.add(childViewController: GFRepoItemViewController(user: user, delegate: self), to: itemViewOne)
        self.add(childViewController: GFFollowerItemViewController(user: user, delegate: self), to: itemViewTwo)
        self.add(childViewController: GFUserInfoHeaderViewController(user: user), to: headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
}


extension UserInfoViewController: GFRepoItemViewControllerDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariViewController(with: url)
    }
}

extension UserInfoViewController: GFFollowerItemViewControllerDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title:"No followers", message: "This user has no followers. What a shame 😞.", buttonTitle: "So sad")
            return
        }
        delegate?.didRequestUser(for: user.login)
        dismissVC()
    }
}

// MARK: - Constants

private extension UserInfoViewController {
    enum Constants {
        static let headerViewHeight: CGFloat = 210
        static let padding: CGFloat = 20
        static let itemHeight: CGFloat = 140
    }
}
