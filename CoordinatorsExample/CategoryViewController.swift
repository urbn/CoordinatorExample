//
//  CategoryViewController.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/13/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import UIKit
import Kingfisher

protocol CategoryViewControllerCoordinatorProtocol: class {
    func didRequestProduct(product: Product)
    func didRequestCategory(category: Category)
}

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let categories: [Category]
    weak var coordinator: CategoryViewControllerCoordinatorProtocol?
    
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
        tableview.registerClass(CategoryTableViewCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? CategoryTableViewCell
        
        cell?.configWithCategory(categories[indexPath.row])
        
        cell?.productTappedBlock = { (product: Product) in
            self.coordinator?.didRequestProduct(product)
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.coordinator?.didRequestCategory(categories[indexPath.row])
    }
}
