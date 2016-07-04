//
//  ViewController.swift
//  roshambo
//
//  Created by Li, Xinli on 6/30/16.
//  Copyright (c) 2016 Li, Xinli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func ver2(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ResultsViewController") as ResultsViewController
        vc.userChoice = getUserShape(sender)
        presentViewController(vc, animated: true, completion: nil)
    }
  
  
    @IBAction func ver1(sender: UIButton) {
        performSegueWithIdentifier("play", sender: sender)

        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "play" {
            let vc = segue.destinationViewController as ResultsViewController
            vc.userChoice = getUserShape(sender as UIButton)
        }
    }
    private func getUserShape(sender: UIButton) -> Shape {
        // Titles are set to one of: Rock, Paper, or Scissors
        let shapes = sender.titleForState(.Normal)!
        return Shape(rawValue: shapes)!
    }


}

