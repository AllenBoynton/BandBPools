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
    
//    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signinButton: UIButton!
    
    private var bannerView: GADBannerView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        if !stackView.isHidden {
//            userField.text = ""
//            emailField.text = ""
//            passwordField.text = ""
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        handleAdRequest()
//        fbAuth()
        self.hideKeyboardWhenTappedAround()
        self.moveKeyboard()
    }
    
    let logoImage: UIImageView = {
        let imageName = "logo"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.rgb(red: 17, green: 43, blue: 95), for: .normal)
        button.titleLabel?.font = UIFont(name: "DINAlternate-Bold", size: 17)
        button.addTarget(self, action: Selector(("loginTapped:")), for: .touchUpInside)
        return button
    }()
    
    let creatorLabel: UILabel = {
        let label = UILabel()
        label.text = "Created by Allen Boynton 2019"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        return label
    }()
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(logoImage)
        view.addSubview(loginButton)
        view.addSubview(creatorLabel)

        let imageContainerView = UIView()
//        imageContainerView.backgroundColor = .blue
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageContainerView)

        imageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logoImage.anchor(nil, left: nil, bottom: imageContainerView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 250, heightConstant: 125)
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loginButton.anchor(imageContainerView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 40, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        creatorLabel.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 55, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: toMenuVC, sender: self)
        } else {
//            userField.text = ""
//            emailField.text = ""
//            passwordField.text = ""
        }
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        handleSignup()
    }
    
    func loginTapped() {
        fbAuth()
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
