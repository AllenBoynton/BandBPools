//
//  ViewController.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth
import BraintreeDropIn
import Braintree

let toMenuVC = "toMenuVC"
let myCell = "MyCell"
let myCollectionCell = "MyCollectionCell"

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        emailField.text = ""
        passwordField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: toMenuVC, sender: self)
//        } else {
            emailField.text = ""
            passwordField.text = ""
//        }
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
    
    @IBAction func payWithBraintree(_ sender: Any) {
        showDropIn(clientTokenOrTokenizationKey: "sandbox_xbx7jkkf_mpjrfk8fjnfw7jcs")
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                 print(result.paymentDescription)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func fetchClientToken() {
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            let clientToken = String(data: data!, encoding: String.Encoding.utf8)
            print(clientToken as Any)
            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
            
            }.resume()
    }
    
    func moveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue.height
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

