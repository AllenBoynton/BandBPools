//
//  ViewController.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth

private let toMenuVC = "toMenuVC"

class HomeController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.moveKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: toMenuVC, sender: self)
        } else {
            emailField.text = ""
            passwordField.text = ""
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
//        if let name = emailField.text, let password = passwordField.text {
//            Auth.auth().signIn(withEmail: name + "@bandbpoolsinc.com", password: password, completion: { (user, error) in
//                if let firebaseError = error {
//                    print(firebaseError.localizedDescription)
//                    return
//                }
//                print("Success!")
//            })
//        }
    }
    
    @IBAction func forgotTapped(_ sender: Any) {
        print("Forgot password tapped")
    }
    
    
}

