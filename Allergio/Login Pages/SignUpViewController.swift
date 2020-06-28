//
//  SignUpViewController.swift
//  Allergio
//
//  Created by Aditya Sharma on 6/23/20.
//  Copyright © 2020 billx. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements();
    }
    
    func setUpElements(){
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }

    // check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns an error message.
    func validateFields() -> String? {
        // Check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields";
        }
        
        // Check that the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(!Utilities.isPasswordValid(cleanedPassword)){
            return "Please make sure that your password is at least 8 characters, contains a special character, and a number.";
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            // There is something wrong with their fields
            showError(error!)
        }else{
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating the user")
                }else{
                    // User successfully created, now store the first and last names
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastName":lastName, "uid": result!.user.uid]) {
                        (error) in
                        
                        if error != nil{
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
            
        }
        
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: "homeVC") as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

}
