//
//  ViewController.swift
//  view
//
//  Created by Li, Xinli on 6/28/16.
//  Copyright (c) 2016 Li, Xinli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    // Present the image picker
    @IBAction func experiment1() {
        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion: nil)
    }

    @IBAction func experiment2() {let controller = UIImagePickerController()
        self.presentViewController(controller, animated: true, completion: nil)}
    
    @IBAction func experiment3() {
        let controller = UIAlertController()
        controller.title = "Test alert"
        controller.message = "This is a test"
        
        // Dismiss the view controller after the user taps “ok”
        let okAction = UIAlertAction (title:"ok", style: UIAlertActionStyle.Default) {
            action in self.dismissViewControllerAnimated(true, completion: nil)
        }
        controller.addAction(okAction)
        self.presentViewController(controller, animated: true, completion:nil)
    }
}

