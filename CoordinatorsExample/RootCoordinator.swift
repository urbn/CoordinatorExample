//
//  RootCoordinator.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/13/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class RootCoordinator: Coordinator {
    let navController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let catVC = CategoryViewController(categories: Category.rootCategories)
        catVC.delegate = self
        addSignInButtonToVC(catVC)
        navController.pushViewController(catVC, animated: false)
    }
    
    func addSignInButtonToVC(vc: UIViewController) {
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .Plain, target: self, action: "signInTapped")
    }
    
    @objc func signInTapped() {
        let authCoordinator = AuthenticationCoordinator(rootViewController: navController)
        authCoordinator.delegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
}

extension RootCoordinator: CategoryViewControllerDelegate, SubCategoryViewControllerDelegate {
    func didRequestCategory(category: Category) {
        if !category.childCategories.isEmpty {
            let catVC = CategoryViewController(categories: category.childCategories)
            catVC.delegate = self
            addSignInButtonToVC(catVC)
            navController.pushViewController(catVC, animated: true)
        }
        else if !category.products.isEmpty {
            let subCatVC = SubCategoryViewController(category: category)
            subCatVC.delegate = self
            addSignInButtonToVC(subCatVC)
            navController.pushViewController(subCatVC, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Nothing to see here", message: "\(category.displayName) has no products. Which is kind dumb, but this is the way fo the world.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "DOH!", style: .Default, handler: nil))
            navController.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func didRequestProduct(product: Product) {
        let pdp = ProductDetailViewController(product: product)
        addSignInButtonToVC(pdp)
        navController.pushViewController(pdp, animated: true)
    }
}

extension RootCoordinator: AuthenticationCoordinatorDelegate {
    func didDismissCoordinator(coordinator: AuthenticationCoordinator, withSuccess success: Bool) {
        childCoordinators.popLast()
        
        var title: String
        var message: String
        if success {
            title = "YAY!"
            message = "Thanks for signing in. We can be friends now"
        }
        else {
            title = "WTF?!"
            message = "You think you're to good to sign in? Fine. GTFO"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "whatever", style: .Default, handler: nil))
        navController.presentViewController(alert, animated: true, completion: nil)
    }
}