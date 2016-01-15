//
//  SubCategoryViewController.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/14/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import UIKit

protocol SubCategoryViewControllerCoordinatorProtocol: class {
    func didRequestProduct(product: Product)
}

class SubCategoryViewController: UIViewController {
    let products: [Product]
    weak var coordinator: SubCategoryViewControllerCoordinatorProtocol?
    
    init(category: Category) {
        self.products = category.products
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = category.displayName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        
        let scrollView = UIScrollView(frame: view.bounds)
        
        let productBtn1 = UIButton(type: .Custom)
        productBtn1.frame = CGRectMake(10.0, 40.0, 300.0, 450.0)
        productBtn1.tag = 0
        productBtn1.addTarget(self, action: "productTapped:", forControlEvents: .TouchUpInside)
        productBtn1.kf_setImageWithURL(NSURL(string: products[0].imgUrl)!, forState: .Normal)
        scrollView.addSubview(productBtn1)
        
        let productBtn2 = UIButton(type: .Custom)
        productBtn2.frame = CGRectMake(10.0, 500.0, 300.0, 450.0)
        productBtn2.tag = 1
        productBtn2.addTarget(self, action: "productTapped:", forControlEvents: .TouchUpInside)
        productBtn2.kf_setImageWithURL(NSURL(string: products[1].imgUrl)!, forState: .Normal)
        scrollView.addSubview(productBtn2)
        
        scrollView.contentSize = CGSizeMake(scrollView.bounds.width, CGRectGetMaxY(productBtn2.frame) + 10.0)
        view.addSubview(scrollView)
    }
    
    func productTapped(sender: UIButton) {
        self.coordinator?.didRequestProduct(products[sender.tag])
    }
}
