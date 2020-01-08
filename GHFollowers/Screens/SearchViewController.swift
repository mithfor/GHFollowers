 //
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 04.01.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListViewController() {
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        
        let followerListVC = FollowerListViewController()
        followerListVC.username = usernameTextField.text
        followerListVC.title = usernameTextField.text
        
        view.endEditing(true)
        usernameTextField.text = ""
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.logoTopConstaraint),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoSideSize),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoSideSize),
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,
                                                   constant: Constants.padding),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Constants.padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                        constant: -Constants.padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: Constants.padding)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                       constant: -Constants.padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.padding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -Constants.padding),
            callToActionButton.heightAnchor.constraint(equalToConstant: Constants.padding)
        ])
    }
 }
 
 extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListViewController()
        return true
    }
 }
 
 extension SearchViewController {
    enum Constants {
        static let padding: CGFloat = 50
        static let logoSideSize: CGFloat = 150
        static let logoTopConstaraint: CGFloat = 80
    }
 }

 
