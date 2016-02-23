//
//  AddViewController.swift
//  Scavenger Hunt
//
//  Created by Sonya Khan on 2/18/16.
//  Copyright © 2016 Sonya Khan. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    
    var newItem: ScavengerHuntItem?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DoneItem" {
            if let name = TextField.text {
                if !name.isEmpty {
                    newItem = ScavengerHuntItem(name: name)
                }
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

