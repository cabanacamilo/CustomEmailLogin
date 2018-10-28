//
//  ViewController.swift
//  CustomEmailLogin
//
//  Created by Camilo Cabana on 10/27/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    var isSignIn = true

    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signSelectorChanged(_ sender: UISegmentedControl)
    {
        isSignIn = !isSignIn // Flip the boolean
        
        if isSignIn == true
        {
            signInLabel.text = "Sign In"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else
        {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton)
    {
        var title = ""
        var message = ""
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            if isSignIn == true
            {
                Auth.auth().signIn(withEmail: email, password: pass)
                { (user, error) in
                    if user != nil
                    {
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else
                    {
                        title = "Incorrect Password or Email"
                        message = "try again with another Pasword or Email"
                        
                        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                        alert.addAction(alertAction)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            else
            {
                Auth.auth().createUser(withEmail: email, password: pass)
                { (user, error) in
                    if user != nil
                    {
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else
                    {
                        title = "Password or Email no available"
                        message = "try again with another Pasword or Email"
                        
                        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                        alert.addAction(alertAction)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}

