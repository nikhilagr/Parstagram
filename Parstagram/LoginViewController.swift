//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Nikhil Agrawal on 06/03/19.
//  Copyright © 2019 Nikhil Agrawal. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true);
    }
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if(success) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let username = usernameField.text
        let password = passwordField.text
        
        PFUser.logInWithUsername(inBackground: username!, password: password!) { (user, error) in
            if ((user) != nil){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
