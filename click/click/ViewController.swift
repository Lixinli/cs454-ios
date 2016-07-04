//
//  ViewController.swift
//  click
//
//  Created by Li, Xinli on 6/28/16.
//  Copyright (c) 2016 Li, Xinli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var count = 0
    @IBOutlet var label : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Lab
        var label = UILabel()
        label.frame = CGRectMake(150,150,60,60)
        label.text = "0"
        
        self.view.addSubview(label)
        self.label = label
        //Button
        var button = UIButton()
        button.frame = CGRectMake(150,250,60,60)
        button.setTitle("Click",forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.view.addSubview(button)
        
        button.addTarget(self, action: "incrementCount", forControlEvents:
            UIControlEvents.TouchUpInside)
    
    }
    
   @IBAction func incrementCount(){
        self.count++
        self.label.text = "\(self.count)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

