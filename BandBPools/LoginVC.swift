//
//  LoginVC.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/28/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftMessages

class LoginVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMessage()
    }
    
    func createMessage() {
        let view = MessageView.viewFromNib(layout: .cardView)
        
        view.configureTheme(.success)
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶", "😎", "🤪", "🙂", "🤗", "🤩", "🤨", "😐", "😑", "😏", "🤐", "😯", "😌", "😛", "😜", "🤑", "😲", "😇", "🤠", "🤡", "🤫",  "🧐", "🤓", "🤖", "🤲", "👐", "🙌", "👏", "🤝", "👍", "👊", "✊", "🤛", "🤜",  "✌️", "🤟", "🤘", "👌", "🖐", "🖖", "👋", "🤙", "💪", "💃🏻", "🕺🏻", "🚜", "⛱", "🏖", "🏝", "🏊‍♂️ ", "🏄🏿‍♂️"].sm_random()!
        view.configureContent(title: "Success", body: "You are logged in!", iconText: iconText)
        view.button?.isHidden = true
        
        // Set options for message
//        var config = SwiftMessages.Config()
        
//        // Dim the background like a popover view. Hide when the background is tapped.
//        config.dimMode = .gray(interactive: true)
        
        SwiftMessages.show(view: view) // config: config,
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("There was a problem logging out")
        }
    }
    
}
