//
//  LoginVC.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/28/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        moveKeyboard()
    }
    
    @IBAction func passwordBtnPressed(_ sender: Any) {
        print("Password sent to email")
    }
    
    func moveKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
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
