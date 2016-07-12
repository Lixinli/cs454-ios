//
//  editViewController.swift
//  Meme
//
//  Created by Li, Xinli on 7/7/16.
//  Copyright © 2016 Li, Xinli. All rights reserved.
//

import UIKit

class editViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var newimage: UIImageView!

        override func viewDidLoad() {
            print(newimage)    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
}
