//
//  DetailViewController.swift
//  Jhilmil
//
//  Created by Aditya Mangal on 7/7/15.
//  Copyright © 2015 Aditya Mangal. All rights reserved.
//

import UIKit
import Parse
import Bolts
import ParseUI


class DetailViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryStatus: UITextField!
    @IBOutlet weak var categorySwitch: UISwitch!
    
    var currentObject : PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Unwrap the current object object
        if let object = currentObject {
            categoryName.text = object["name"] as? String
            let status = object["status"] as! Bool
            categorySwitch.setOn(status, animated:true)
            
            navigationItem.title = categoryName.text
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveButton(sender: AnyObject) {
        // Unwrap the current object object
        if let object = currentObject {
            
            object["name"] = categoryName.text
            object["status"] = categorySwitch.on
            
            // Save the data back to the server in a background task
            object.saveEventually(nil)
            
        }
        
        // Return to table view
        self.navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
