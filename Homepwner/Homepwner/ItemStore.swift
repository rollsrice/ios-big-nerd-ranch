//
//  ItemStore.swift
//  Homepwner
//
//  Created by Ryan Zhang on 2016-02-13.
//  Copyright © 2016 Ryan Zhang. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}