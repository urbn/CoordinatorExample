//
//  Models.swift
//  CoordinatorsExample
//
//  Created by Jason Grandelli on 1/13/16.
//  Copyright © 2016 URBN. All rights reserved.
//

import Foundation

class Category: CustomStringConvertible {
    let categoryId: String
    let displayName: String
    let childCategories: [Category]
    var products: [Product] = []
    
    static func inflateCategoriesWithData(data: [[String: AnyObject]]) -> [Category] {
        var categories: [Category] = []
        for obj in data {
            let category = Category(data: obj)
            categories.append(category)
        }
        
        return categories
    }
    
    init(data: Dictionary<String, AnyObject>) {
        self.categoryId = data["categoryId"] as? String ?? ""
        self.displayName = data["displayName"] as? String ?? ""
        
        if let children = data["children"] as? [[String: AnyObject]] {
            self.childCategories = Category.inflateCategoriesWithData(children)
        }
        else {
            self.childCategories = []
        }
        
        if let products = data["products"] as? [[String: AnyObject]] {
            for obj in products {
                self.products.append(Product(data: obj))
            }
        }
    }
    
    var description: String {
        return "{id: \(self.categoryId), children: \(self.childCategories)}"
    }
}

class Product {
    let displayName: String
    let imgUrl: String
    
    init(data: Dictionary<String, AnyObject>) {
        self.displayName = data["displayName"] as? String ?? ""
        self.imgUrl = data["imgUrl"] as? String ?? ""
    }
}