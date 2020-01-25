//
//  GFUserInfoHeaderViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 25.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {

    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: Constants.userNameLabelHeight)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIElements()
    }
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension GFUserInfoHeaderViewController {
    
    // TODO: - make FOR loop
    func addSubViews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Constraints.padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Constraints.avatarImageSideSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.avatarImageSideSize),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.Constraints.textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: Constants.userNameLabelHeight),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.Constraints.textImagePadding),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.userLabelHeight),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.padding),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.Constraints.textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: Constants.Constraints.locationImageViewWidth),
            locationImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.locationImageViewHeight),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.padding),
            locationLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.locationImageViewHeight),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.Constraints.textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

private extension GFUserInfoHeaderViewController {
    enum Constants{
        enum Constraints {
            static let avatarImageSideSize: CGFloat             = 90
            static let padding: CGFloat                         = 20
            static let textImagePadding: CGFloat                = 12
            static let locationImageViewWidth: CGFloat          = 20
            static let locationImageViewHeight:CGFloat          = 20
        }
        static let userNameTextHeight: CGFloat                  = 34
        static let userNameLabelHeight:CGFloat                  = 38
        static let userLabelHeight: CGFloat                     = 20
    }
}
