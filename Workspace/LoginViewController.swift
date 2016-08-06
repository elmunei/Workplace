//
//  LoginViewController.swift
//  Workspace
//
//  Created by Elvis Tapfumanei on 8/3/16.
//  Copyright © 2016 Elmunei. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let backendless = Backendless.sharedInstance()
    
    var email: String?
    var password: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: IBActions
    
    @IBAction func loginBarButton(sender: UIBarButtonItem) {
   
        
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            self.email = emailTextField.text
            self.password = passwordTextField.text
            
            // Login User
            
            loginUser(email!, password: password!)
            
            
        } else {
            
            //show an error to user
            
            ProgressHUD.showError("All fields are required")
            
        }
        
    }
    
    func loginUser(email: String, password : String){
        
        backendless.userService.login(email, password: password, response: { (user : BackendlessUser!) -> Void in
            
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            
            
            
            //segue to RecentViewController
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC") as! UITabBarController
            
            vc.selectedIndex = 0
            
            self.presentViewController(vc, animated: true, completion: nil)
            
            
            
            ProgressHUD.showSuccess("Login Successful!")
            
        }) { (fault : Fault!) -> Void in
            
            ProgressHUD.showError("Login Failure!")
        }
        
        
    }

    
}
