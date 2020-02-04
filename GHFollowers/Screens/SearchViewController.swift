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
    var logoImageViewTopContraint: NSLayoutConstraint?
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,
                         usernameTextField,
                         callToActionButton)
        configureLogoImageView()
        configureUsernameTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
        usernameTextField.text = ""
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListViewController() {
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        
        let followerListVC = FollowerListViewController(username: usernameTextField.text!)
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        if let topAnchor = view?.safeAreaLayoutGuide.topAnchor {
            logoImageViewTopContraint = logoImageView.topAnchor.constraint(equalTo:  topAnchor, constant: topConstraintConstant)
            logoImageViewTopContraint?.isActive = true
        }
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: Constants.logoSideSize),
            logoImageView.widthAnchor.constraint(equalToConstant: Constants.logoSideSize),
        ])
    }
    
    func configureUsernameTextField() {
       
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
    }
 }

 
