//
//  GFItemInfoViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 25.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class GFItemInfoViewController: UIViewController {

    // MARK: - Public vars
    
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    var user: User?
    
    // MARK: - Inits
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateBackGroundView()
        layoutUI()
        configureStackView()
    }
}

    // MARK: - Private methods

private extension GFItemInfoViewController {
    func configurateBackGroundView() {
        view.layer.cornerRadius = Constants.actionButtonCornerRadius
        view.backgroundColor = .secondarySystemBackground
    }
    
    func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Constraints.padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.padding),
            stackView.heightAnchor.constraint(equalToConstant: Constants.Constraints.stackViewHeight),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.Constraints.padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Constraints.padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Constraints.padding),
            actionButton.heightAnchor.constraint(equalToConstant: Constants.Constraints.actionButtonHeight)
        ])
    }
}

private extension GFItemInfoViewController {
    enum Constants {
        enum Constraints {
            static let padding: CGFloat = 20
            static let stackViewHeight: CGFloat = 50
            static let actionButtonHeight: CGFloat = 44
        }
        
        static let actionButtonCornerRadius: CGFloat = 18
    }
}
