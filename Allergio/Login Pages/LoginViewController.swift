//
//  LoginViewController.swift
//  Allergio
//
//  Created by Aditya Sharma on 6/23/20.
//  Copyright © 2020 billx. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: Any) {
        // Validate Text Fields
        
        // Create clean versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if err != nil {
                self.errorLabel.text = err!.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "homeVC") as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
}
