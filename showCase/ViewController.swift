//
//  ViewController.swift
//  showCase
//
//  Created by 蔡智斌 on 16/5/20.
//  Copyright © 2016年 NeoChoi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit



class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil{
            self.performSegueWithIdentifier("SEGUE_LOGGED_IN", sender: nil)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fbBtnPressed(sender: UIButton!){
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            if facebookError != nil{
                print("Facebook login failed. Error \(facebookError)")
            }else{
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook. \(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: {error,authData in
                    if error != nil{
                        print("Login failed. \(error)")
                    }else{
                        print("Logged In! \(authData)")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "KEY_UID")
                        
                        self.performSegueWithIdentifier("SEGUE_LOGGED_IN", sender: nil)
                    }
                })
            }
        }
    }
    @IBAction func attemptLogin(sender: UIButton!){
        if let email = emailField.text where email != "",let pwd = passwordField.text where pwd != ""{
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                if error != nil{
                    print(error)
                    
                
                    
                }
            })
        }else{
            self.showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
            
            
        }
    }
    
    func showErrorAlert(title: String,msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}

