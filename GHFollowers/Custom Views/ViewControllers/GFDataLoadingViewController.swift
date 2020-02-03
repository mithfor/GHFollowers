//
//  GFDataLoadingViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Voronin on 01.02.2020.
//  Copyright © 2020 Mithfor. All rights reserved.
//

import UIKit

class GFDataLoadingViewController: UIViewController {

    var containerView: UIView!
}

extension GFDataLoadingViewController {
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activitiIndicator)
        
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activitiIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activitiIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activitiIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptySpaceView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
