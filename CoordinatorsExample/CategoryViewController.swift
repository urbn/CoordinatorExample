//
//  CategoryViewController.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/13/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import UIKit
import Kingfisher

protocol CategoryViewControllerDelegate: class {
    func didRequestProduct(product: Product)
    func didRequestCategory(category: Category)
}

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let categories: [Category]
    weak var delegate: CategoryViewControllerDelegate?
    
    init(categories: [Category]) {
        self.categories = categories
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purpleColor()
        
        let tableview = UITableView(frame: view.bounds, style: .Plain)
        tableview.registerClass(ShoppingTableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 44.0
        view.addSubview(tableview)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? ShoppingTableViewCell
        
        cell?.configWithCategory(categories[indexPath.row])
        
        cell?.productTappedBlock = { (product: Product) in
            self.delegate?.didRequestProduct(product)
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.delegate?.didRequestCategory(categories[indexPath.row])
    }
}


class ShoppingTableViewCell: UITableViewCell {
    typealias ProductTappedBlock = (Product) -> (Void)
    
    let label: UILabel
    let product1: UIButton
    let product2: UIButton
    var category: Category?
    var buttonVerticalConstraints: [NSLayoutConstraint]?
    var buttonCollapsedVerticalConstraints: [NSLayoutConstraint]?
    var productTappedBlock: ProductTappedBlock?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        product1 = UIButton(type: .Custom)
        product1.translatesAutoresizingMaskIntoConstraints = false
        product1.backgroundColor = .redColor()
        product1.tag = 0
        
        product2 = UIButton(type: .Custom)
        product2.translatesAutoresizingMaskIntoConstraints = false
        product2.backgroundColor = .blueColor()
        product2.tag = 1
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        product1.addTarget(self, action: "productTapped:", forControlEvents: .TouchUpInside)
        product2.addTarget(self, action: "productTapped:", forControlEvents: .TouchUpInside)
        
        contentView.addSubview(label)
        contentView.addSubview(product1)
        contentView.addSubview(product2)
        
        let views = ["label": label, "p1": product1, "p2": product2]
        
        self.buttonVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[p1(==150)]-30-|",
            options: [],
            metrics: nil,
            views: views
        )
        
        self.buttonCollapsedVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[p1(==0)]|",
            options: [],
            metrics: nil,
            views: views
        )
        
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-[label]",
                options: [],
                metrics: nil,
                views: views
            )
        )
        
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-[p1(==100)]-12-[p2(==p1)]",
                options: [.AlignAllTop],
                metrics: nil,
                views: views
            )
        )
        
        NSLayoutConstraint.activateConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|-[label]-[p1]",
                options: [],
                metrics: nil,
                views: views
            )
        )
        
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(
                item: product2,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: product1,
                attribute: .Height,
                multiplier: 1.0,
                constant: 0.0
            )
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configWithCategory(category: Category) {
        self.category = category
        
        label.text = category.displayName
        
        if (category.products.isEmpty) {
            NSLayoutConstraint.activateConstraints(buttonCollapsedVerticalConstraints!)
        }
        else {
            NSLayoutConstraint.activateConstraints(buttonVerticalConstraints!)
            
            if let url1 = NSURL(string: category.products[0].imgUrl) {
                product1.kf_setImageWithURL(url1, forState: UIControlState.Normal)
            }
            
            if let url2 = NSURL(string: category.products[1].imgUrl) {
                product2.kf_setImageWithURL(url2, forState: UIControlState.Normal)
            }
        }
    }
    
    override func prepareForReuse() {
        NSLayoutConstraint.deactivateConstraints(buttonVerticalConstraints!)
        NSLayoutConstraint.deactivateConstraints(buttonCollapsedVerticalConstraints!)
        
        super.prepareForReuse()
    }
    
    func productTapped(sender: UIButton) {
        productTappedBlock?(category!.products[sender.tag])
    }
}
