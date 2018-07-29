//
//  LoginVC.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/28/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("There was a problem logging out")
        }
    }
    
}
