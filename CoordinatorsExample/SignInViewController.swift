//
//  SignInViewController.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/14/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: class {
    func didRequestSignIn()
    func didRequestCreateAccount()
}

class SignInViewController: UIViewController {
    weak var delegate: SignInViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        
        let signInButton = UIButton(type: .RoundedRect)
        signInButton.frame = CGRectMake(0, 0, 200.0, 44.0)
        signInButton.layer.borderColor = UIColor.blueColor().CGColor
        signInButton.layer.borderWidth = 2.0
        signInButton.layer.cornerRadius = 6
        signInButton.tintColor = .orangeColor()
        signInButton.setTitle("Sign In", forState: .Normal)
        signInButton.center = CGPointMake(view.center.x, view.center.y - CGRectGetMidY(signInButton.frame) - 10)
        signInButton.addTarget(self, action: "signInTapped", forControlEvents: .TouchUpInside)
        view.addSubview(signInButton)
        
        let createAccount = UIButton(type: .RoundedRect)
        createAccount.frame = CGRectMake(0, 0, 200.0, 44.0)
        createAccount.layer.borderColor = UIColor.redColor().CGColor
        createAccount.layer.borderWidth = 2.0
        createAccount.layer.cornerRadius = 6
        createAccount.tintColor = .redColor()
        createAccount.setTitle("Create Account", forState: .Normal)
        createAccount.center = CGPointMake(view.center.x, view.center.y + CGRectGetMidY(createAccount.frame) + 10)
        createAccount.addTarget(self, action: "createAccountTapped", forControlEvents: .TouchUpInside)
        view.addSubview(createAccount)
    }
    
    func signInTapped() {
        self.delegate?.didRequestSignIn()
    }
    
    func createAccountTapped() {
        self.delegate?.didRequestCreateAccount()
    }
}
