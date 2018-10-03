//
//  LoginViewController.swift
//  ChatNout
//
//  Created by Joakim Jorde on 9/28/18.
//  Copyright © 2018 Joakim Jorde. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let fillOut_alertController = UIAlertController(title: "Error", message: "All fields must be filled out.", preferredStyle: .alert)
     let invalidUser_alertController = UIAlertController(title: "Error", message: "Invalid username/password", preferredStyle: .alert)
     let userExsist_alertController = UIAlertController(title: "Error", message: "This username is taken.", preferredStyle: .alert)
     let somethingWrong_alertController = UIAlertController(title: "Error", message: "Something went wrong.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // create an OK action
        let fillOut_OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        let invalidUser_OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        let userExsist_OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        let somethingWrong_OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        fillOut_alertController.addAction(fillOut_OKAction)
        invalidUser_alertController.addAction(invalidUser_OKAction)
        userExsist_alertController.addAction(userExsist_OKAction)
        somethingWrong_alertController.addAction(somethingWrong_OKAction)
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            present(fillOut_alertController, animated: true) { }
        }
        else
        {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
       // newUser.email = emailField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                if error._code == 202{
                    self.present(self.userExsist_alertController, animated: true) { }
                    print("username is taken.")
                }
                else
                {
                    self.present(self.somethingWrong_alertController, animated: true) { }
                    print(error.localizedDescription)
                }
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        }
        
      
    }
    
    @IBAction func login(_ sender: Any) {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            present(fillOut_alertController, animated: true) { }
        }
        else
        {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                if error._code == 101{
                    self.present(self.invalidUser_alertController, animated: true) { }
                    print("Invalid Username/password")
                }
                else
                {
                    self.present(self.somethingWrong_alertController, animated: true) { }
                    print("User log in failed: \(error.localizedDescription)")
                }
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
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
