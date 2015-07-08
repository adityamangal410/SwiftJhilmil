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
        self.textKey = "name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Categories")
        query.orderByAscending("name")
        return query
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
        
        // Get the new view controller using [segue destinationViewController].
        let detailScene = segue.destinationViewController as! DetailViewController
        
        // Pass the selected object to the destination view controller.
//        if let indexPath = self.tableView.indexPathForSelectedRow! {
//            let row = Int(indexPath.row)
//            detailScene.currentObject = (objects?[row] as! PFObject)
//        }
        if let selectedCategoryCell = sender as? CategoryTableViewCell {
            let indexPath = tableView.indexPathForCell(selectedCategoryCell)!
            let row = Int(indexPath.row)
            detailScene.currentObject = (objects?[row] as! PFObject)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Refresh the table to ensure any data changes are displayed
        tableView.reloadData()
    }
}
