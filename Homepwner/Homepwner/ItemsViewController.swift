//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Ryan Zhang on 2016-02-13.
//  Copyright © 2016 Ryan Zhang. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the height of the status bar
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        if let background = UIImage(named: "background") {
            tableView.backgroundColor = UIColor(patternImage: background)
        }
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // +1 to show no more items cell
        return itemStore.allItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)

        if indexPath.row == itemStore.allItems.count {
            cell.textLabel?.text = "No more items!"
            return cell
        }
        else {
            let item = itemStore.allItems[indexPath.row]

            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            cell.heightAnchor.constraintEqualToConstant(60)
            cell.textLabel?.font = cell.textLabel?.font.fontWithSize(20)

            return cell
        }
    }
}
