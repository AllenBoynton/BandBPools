//
//  ViewController.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.setPadding()
        passwordField.setPadding()
        moveKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.presentLoggedInScreen()
        } else {
            emailField.text = ""
            passwordField.text = ""
        }
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if let name = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: name + "@bandbpoolsinc.com", password: password, completion: { (user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    return
                }
                self.presentLoggedInScreen()
                print("Success!")
            })
        }
    }
    
    @IBAction func forgotTapped(_ sender: Any) {
        
    }
    
    func presentLoggedInScreen() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let menuVC: MenuVC = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        self.present(menuVC, animated: true, completion: nil)
    }
    
    func moveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.height
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = -0.4 * keyboardHeight
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.window?.frame.origin.y = 0
            self.view.layoutIfNeeded()
        })
    }
}

