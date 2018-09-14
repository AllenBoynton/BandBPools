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
import WebKit

class MenuVC: UIViewController {
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createMessage()
        urlTextField.delegate = self
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handleWebView()
    }
    
    func handleWebView() {
        let urlString = "http://bbpemp.secureasap.com/login.php"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        urlTextField.text = urlString
    }
    

    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("There was a problem logging out")
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forwardButtonTapped(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        if webView.isLoading {
            webView.stopLoading()
        } else {
            do {
                try Auth.auth().signOut()
                dismiss(animated: true, completion: nil)
            } catch {
                print("There was a problem logging out")
            }
//            self.dismiss(animated: true, completion: nil)
        }
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
        
        SwiftMessages.show(view: view) // config: config,
    }
}

extension MenuVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = urlTextField.text!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
}

extension MenuVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
        
        urlTextField.text = webView.url?.absoluteString
    }
}

