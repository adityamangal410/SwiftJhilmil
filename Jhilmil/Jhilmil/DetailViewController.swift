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
    @IBOutlet weak var categorySwitch: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
    

    // MARK: - Navigation

    @IBAction func cancel(sender: AnyObject) {
        let isPresentingInAddCategoryMode = presentingViewController is UINavigationController
        if isPresentingInAddCategoryMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if saveButton === sender {
            let isPresentingInAddCategoryMode = presentingViewController is UINavigationController
            if isPresentingInAddCategoryMode {
                let object = PFObject(className:"Categories")
                
                object["name"] = categoryName.text
                object["status"] = categorySwitch.on
                
                // Save the data back to the server in a background task
                object.saveEventually(nil)
//                currentObject = object
            }
            else {
                if let object = currentObject {
                    
                    object["name"] = categoryName.text
                    object["status"] = categorySwitch.on
                    
                    // Save the data back to the server in a background task
                    object.saveEventually(nil)
                    
                }
            }
        }
    }


}
