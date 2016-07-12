//
//  ViewController.swift
//  Meme
//
//  Created by Li, Xinli on 7/7/16.
//  Copyright © 2016 Li, Xinli. All rights reserved.
//

import UIKit

class ViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    
    //Vars
    let memeTextAttributes = [ NSStrokeColorAttributeName: UIColor.blackColor(), NSForegroundColorAttributeName: UIColor.whiteColor() , NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: NSNumber(double: -3.0) ]
    var memeImageNew:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.defaultTextAttributes = memeTextAttributes
        text.textAlignment = .Center
        tabBarController?.dismissViewControllerAnimated(true, completion: nil)
        toggleEnabled(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
        subscribeToKeyboardNotifications()
        subscribeToKeyboardNotificationsHide()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardNotificationsHide()
    }

    // dismiss keyboard from textfields
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Keyboard Notifications
    func keyboardWillHide(notification: NSNotification){
        if(text.isFirstResponder()) {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillShow(notification: NSNotification){
        if(text.isFirstResponder()) {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    //NSNotifications
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardNotificationsHide() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil )
        
    }
    
    func unsubscribeFromKeyboardNotificationsHide(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //Creating Meme and storing it in the AppDelegate array
    func save() {
        var meme = Meme(text: text.text!, image: imageView.image!, memedImage: memeImageNew)
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
    }
    
    //Creating Meme image
    func generateMemedImage() -> UIImage {
        toggleNavs(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        toggleNavs(false)
        return memeImage
    }
    
    //IBActions
    @IBAction func shareMeme(sender: UIBarButtonItem) {
        memeImageNew = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [memeImageNew], applicationActivities: [])
        presentViewController(vc, animated: true, completion: nil)
        shareButton.enabled = false
        imageView.image = memeImageNew
        vc.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.save()
               
                let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("editViewController") as! editViewController
                nextVC.newimage = self.imageView
                nextVC.newimage.image = self.memeImageNew
                self.presentViewController(nextVC, animated: true, completion: nil)
            }
        }
        
        }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // User selected an image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelEdit(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickAnImageWithCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        toggleEnabled(true)
    }
    
    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        toggleEnabled(true)
    }
    
    
    //Helper functions
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func toggleEnabled(toggle:Bool) {
        shareButton.enabled = toggle
        text.enabled = toggle
    }
    
    func toggleNavs(toggle:Bool) {
        navigationController?.setNavigationBarHidden(toggle, animated: false)
        //toolbar.hidden = toggle
        navBar.hidden = toggle
    }

    
}

