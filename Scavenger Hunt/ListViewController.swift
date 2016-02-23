//
//  ListViewController.swift
//  Scavenger Hunt
//
//  Created by Sonya Khan on 2/18/16.
//  Copyright © 2016 Sonya Khan. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let myManager = ItemsManager()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedItem = myManager.itemsList[indexPath.row]
            
            let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            selectedItem.image = photo
            
            myManager.save()
            
            dismissViewControllerAnimated(true, completion: {
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
        }
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        if segue.identifier == "DoneItem" {
            let addVC = segue.sourceViewController as! AddViewController
            if let newItem = addVC.newItem {
                myManager.itemsList += [newItem]
                myManager.save()
                let indexPath = NSIndexPath(forRow: myManager.itemsList.count - 1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myManager.itemsList.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell", forIndexPath: indexPath)
        
        let item = myManager.itemsList[indexPath.row]
        cell.textLabel?.text = item.name
        
        if item.completed {
            
            cell.accessoryType = .Checkmark
            cell.imageView?.image = item.image
            
        }
        
        else {
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
        return cell
    }
}