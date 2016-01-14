//
//  ProductDetailViewController.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/14/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    let product: Product

    init(product: Product) {
        self.product = product
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = product.displayName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .whiteColor()
        
        self.edgesForExtendedLayout = .None

        let productImg = UIImageView(frame: CGRectMake(10, 20.0, 300, 450))
        productImg.kf_setImageWithURL(NSURL(string: product.imgUrl)!)
        view.addSubview(productImg)
    }
}
