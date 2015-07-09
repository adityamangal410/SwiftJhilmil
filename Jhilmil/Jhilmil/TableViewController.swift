//
//  TableViewController.swift
//  Jhilmil
//
//  Created by Aditya Mangal on 7/7/15.
//  Copyright © 2015 Aditya Mangal. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI

class TableViewController: PFQueryTableViewController {

    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Categories"
//        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Categories")
        query.orderByAscending("name")
        return query
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {

        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CategoryTableViewCell

        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["name"] as? String {
            cell.nameLabel.text = name
        }
        if let status = object?["status"] as? Bool {
            cell.statusSwitch.setOn(status, animated:true)
        }
        
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            // Get the new view controller using [segue destinationViewController].
            let detailScene = segue.destinationViewController as! DetailViewController
            
            if let selectedCategoryCell = sender as? CategoryTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedCategoryCell)!
                let row = Int(indexPath.row)
                detailScene.currentObject = (objects?[row] as! PFObject)
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new Category..")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        print("View Appeared!")
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
        loadObjects()
    }
    
    @IBAction func unwindToCategoryList(sender: UIStoryboardSegue) {
        if let _ = sender.sourceViewController as? DetailViewController
        {
            print("Back To table!")
            
            // Refresh the table to ensure any data changes are displayed
            tableView.reloadData()
        }
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let row = Int(indexPath.row)
            var object : PFObject?
            object = (objects?[row] as! PFObject)
            object!.deleteInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    // The object has been deleted.
                    self.loadObjects()
                } else {
                    // There was a problem, check error.description
                    print("Object Deletion Failed!")
                }
            }
//            object!.deleteEventually()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}
