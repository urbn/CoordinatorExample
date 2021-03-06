//
//  AuthenticationCoordinator.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/14/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import UIKit

protocol AuthenticationCoordinatorCoordinatorProtocol: class {
    func didDismissCoordinator(coordinator: AuthenticationCoordinator, withSuccess success: Bool)
}

class AuthenticationCoordinator: Coordinator {
    let rootViewController: UIViewController
    let navController: UINavigationController = UINavigationController()
    weak var coordinator: AuthenticationCoordinatorCoordinatorProtocol?
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        let signInVC = SignInViewController()
        signInVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "canceled")
        signInVC.coordinator = self
        navController.pushViewController(signInVC, animated: false)

        rootViewController.presentViewController(navController, animated: true, completion: nil)
    }
    
    @objc func canceled() {
        dismissWithSuccess(false)
    }
    
    func dismissWithSuccess(success: Bool) {
        navController.dismissViewControllerAnimated(true) { () -> Void in
            self.coordinator?.didDismissCoordinator(self, withSuccess: success)
        }
    }
}

extension AuthenticationCoordinator: SignInViewControllerCoordinatorProtocol {
    func didRequestSignIn() {
        dismissWithSuccess(true)
    }
    
    func didRequestCreateAccount() {
        let vc = UIViewController()
        vc.view.backgroundColor = .whiteColor()
        
        navController.pushViewController(vc, animated: true)
    }
}