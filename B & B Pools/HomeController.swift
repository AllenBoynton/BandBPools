//
//  ViewController.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseUI
import Fabric
import GoogleMobileAds
import GoogleSignIn
import FBSDKLoginKit

private let toMenuVC = "toMenuVC"

class HomeController: UIViewController, AuthUIDelegate, GIDSignInUIDelegate, FUIAuthDelegate {
    
    // Signin StackView
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    private var bannerView: GADBannerView!
    
    override func viewWillAppear(_ animated: Bool) {
        if !stackView.isHidden {
            userField.text = ""
            emailField.text = ""
            passwordField.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        googleAuth()
        fbAuth()
        handleAdRequest()
        self.hideKeyboardWhenTappedAround()
        self.moveKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: toMenuVC, sender: self)
        } else {
            userField.text = ""
            emailField.text = ""
            passwordField.text = ""
        }
    }
    
    private func googleAuth() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    private func fbAuth() {
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI?.delegate = self
        
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()!),
            ]
        authUI?.providers = providers
        
        let authViewController = authUI?.authViewController()
        
        self.present(authViewController!, animated: true) { }
    }
    
    private func handleSignup() {
        guard let username = userField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil && user != nil {
                print("Success! Email: \(email), Password: \(password)")
                self.performSegue(withIdentifier: toMenuVC, sender: self)
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    if error == nil {
                        print("User display name changed! User: \(username)")
                    }
                })
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        })
    }
    
    private func handleLogin() {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let firebaseError = error {
                    print("Error: \(firebaseError.localizedDescription)")
                    return
                } else {
                    print("Success! Email: \(email), Password: \(password)")
                    
                    self.performSegue(withIdentifier: toMenuVC, sender: self)
                }
            })
        }
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        handleSignup()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        handleLogin()
    }
    
    @IBAction func handleLoginViews(_ sender: Any) {
        stackView.isHidden = false
        userField.isHidden = true
        emailField.isHidden = false
        passwordField.isHidden = false
        signupButton.isHidden = true
        loginButton.isHidden = false
        forgotButton.isHidden = false
        logInButton.isHidden = true
        signinButton.isHidden = false
    }
    
    @IBAction func handleSigninViews(_ sender: Any) {
        stackView.isHidden = false
        userField.isHidden = false
        emailField.isHidden = false
        passwordField.isHidden = false
        signupButton.isHidden = false
        loginButton.isHidden = true
        forgotButton.isHidden = true
        logInButton.isHidden = false
        signinButton.isHidden = true
    }
    
    // Send a password reset email
    @IBAction func forgotTapped(_ sender: Any) {
        // Alert to prompt user for email
        guard let email = emailField.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in

            print("Forgot password tapped: Sending email to reset!")
        }
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                // An error happened.
                if user == nil {
                    print("Deleting error: \(error.localizedDescription)")
                }
            } else {
                // Account deleted.
                print("Success deleting user!")
            }
        }
    }
}

extension HomeController: GADBannerViewDelegate {
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        if #available(iOS 11.0, *) {
            // In iOS 11, we need to constrain the view to the safe area.
            positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
        }
        else {
            // In lower iOS versions, safe area is not available so we use
            // bottom layout guide and view edges.
            positionBannerViewFullWidthAtBottomOfView(bannerView)
        }
    }
    
    // MARK: - view positioning
    @available (iOS 11, *)
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        // Position the banner. Stick it to the bottom of the Safe Area.
        // Make it constrained to the edges of the safe area.
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
            guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
            guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
            ])
    }
    
    func positionBannerViewFullWidthAtBottomOfView(_ bannerView: UIView) {
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .leading,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: view,
                                              attribute: .trailing,
                                              multiplier: 1,
                                              constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: view.safeAreaLayoutGuide.bottomAnchor,
                                              attribute: .top,
                                              multiplier: 1,
                                              constant: 0))
    }
    
    // AdMob banner ad
    func handleAdRequest() {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        addBannerViewToView(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"//"ca-app-pub-2292175261120907/4964310398"
        bannerView.rootViewController = self
        bannerView.delegate = self
        
        bannerView.load(request)
    }
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
}
