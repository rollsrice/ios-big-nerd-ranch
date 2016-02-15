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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // +1 to show no more items cell
        return itemStore.allItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Get new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        
        cell.updateLabels()

        if indexPath.row == itemStore.allItems.count {
            cell.nameLabel.text = "No more items!"
            return cell
        }
        else {
            let item = itemStore.allItems[indexPath.row]

            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"

            return cell
        }
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == itemStore.allItems.count {
            return false
        }
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = itemStore.allItems[indexPath.row]

            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"

            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)

            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)

            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: { _ in
                self.itemStore.removeItem(item)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            ac.addAction(deleteAction)

            presentViewController(ac, animated: true, completion: nil)
        }
    }

    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Remove"
    }

    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        return proposedDestinationIndexPath.row == itemStore.allItems.count ? sourceIndexPath : proposedDestinationIndexPath
    }

    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }

    @IBAction func addNewItem(sender: AnyObject) {
        let newItem = itemStore.createItem()
        if let index = itemStore.allItems.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    @IBAction func toggleEditingMode(sender: AnyObject) {
        if editing {
            sender.setTitle("Edit", forState: .Normal)
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", forState: .Normal)
            setEditing(true, animated: true)
        }
    }
}
