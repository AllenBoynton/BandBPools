//
//  ViewController.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var newUserBtn: DesignableButtons!
    @IBOutlet weak var imgContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func newUserBtnPressed(_ sender: Any) {
        print("New User button pressed")
    }
}

