//
//  GFUserInfoHeaderViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 25.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class GFUserInfoHeaderViewController: UIViewController {

    //MARK: - Public vars
    
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: Constants.Constraints.userNameTextHeight)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: Constants.Size.secondaryTitleLabelText)
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    var subviews: [UIView]?
    
    var user: User!
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(avatarImageView,
                         usernameLabel,
                         nameLabel,
                         locationImageView,
                         locationLabel,
                         bioLabel)
        
        layoutUI()
        configureUIElements()
    }
    
    //MARK: - Inits
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension GFUserInfoHeaderViewController {

    func configureUIElements() {
        avatarImageView.downloadImage(fromURL: user.avatarUrl ?? "")
        
        usernameLabel.text          = user.login
        nameLabel.text              = user.name ?? "No name available"
        locationLabel.text          = user.location ?? "No location"
        bioLabel.text               = user.bio ?? "No bio available"
        bioLabel.numberOfLines      = 3
        
        locationImageView.image     = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    func layoutUI() {
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Constraints.padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.Size.avatarImageSide),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.Size.avatarImageSide),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.Constraints.textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.userNameLabelHeight),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.Constraints.textImagePadding),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.userLabelHeight),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.padding),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.Constraints.textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: Constants.Constraints.locationImageViewWidth),
            locationImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.locationImageViewHeight),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.locationImageViewHeight),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.Constraints.textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.bioLabelHeight)
        ])
    }
    
    

}

    // MARK: - Constants

private extension GFUserInfoHeaderViewController {
    enum Constants{
        enum Constraints {
            static let padding: CGFloat                 = 20
            static let textImagePadding: CGFloat        = 12
            static let locationImageViewWidth: CGFloat  = 20
            static let locationImageViewHeight:CGFloat  = 20
            static let userNameTextHeight: CGFloat      = 34
            static let userNameLabelHeight:CGFloat      = 38
            static let userLabelHeight: CGFloat         = 20
            static let bioLabelHeight: CGFloat          = 90
        }
        
        enum Size {
            static let avatarImageSide: CGFloat         = 90
            static let secondaryTitleLabelText: CGFloat = 18
        }
    }
}
