//
//  LoginViewController.swift
//  B & B Pools
//
//  Created by Allen Boynton on 2/2/19.
//  Copyright © 2019 Allen Boynton. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import Fabric
import GoogleMobileAds
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    private var bannerView: GADBannerView!
    private var fbLoginButton = FBSDKLoginButton()
    private var googleButton = GIDSignInButton()
    private var stackView: UIStackView!
    private var textStackView: UIStackView!
    private var socialMediaStack: UIStackView!
    private var buttonStackView: UIStackView!
    
    private let bgImageView: UIImageView = {
        let imageName = "bg1"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let logoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "POOLFINDER", attributes: [NSAttributedString.Key.font : UIFont(name: "Verdana-BoldItalic", size: 22)!, NSAttributedString.Key.foregroundColor : UIColor.mainBlue])
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    private let logoImage: UIImageView = {
        let imageName = "logo"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let userField: UITextFieldPadding = {
        let field = UITextFieldPadding()
        field.placeholder = "Username"
        field.autocapitalizationType = .none
        field.backgroundColor = .white
        field.layer.cornerRadius = 5.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.mainBlue.cgColor
        field.returnKeyType = .next
        field.keyboardType = .default
        return field
    }()
    
    private let emailField: UITextFieldPadding = {
        let field = UITextFieldPadding()
        field.placeholder = "Email"
        field.autocapitalizationType = .none
        field.backgroundColor = .white
        field.layer.cornerRadius = 5.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.mainBlue.cgColor
        field.returnKeyType = .next
        field.keyboardType = .emailAddress
        return field
    }()
    
    private let passwordField: UITextFieldPadding = {
        let field = UITextFieldPadding()
        field.placeholder = "Password"
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.backgroundColor = .white
        field.layer.cornerRadius = 5.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.mainBlue.cgColor
        field.returnKeyType = .done
        return field
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot your password?", for: .normal)
        button.setTitleColor(.mainBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "DINAlternate-Bold", size: 13)
        button.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)
        return button
    }()
    
    //    private let customFBLoginButton: UIButton = {
    //        let title = "Login with Facebook"
    //        let button = UIButton(type: .custom)
    //        var image = UIImage(named: "f")
    //        button.backgroundColor = UIColor.rgb(red: 66, green: 89, blue: 147)
    //        button.setTitle(title, for: .normal)
    //        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
    //        button.setTitleColor(.white, for: .normal)
    //        button.setImage(image, for: .normal)
    //        button.layer.cornerRadius = 5.0
    //        button.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    //        button.imageView?.contentMode = .scaleAspectFit
    //        button.imageView?.backgroundColor = UIColor.mainBlue
    //        button.layer.masksToBounds = true
    //        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -160, bottom: 0, right: 0)
    //        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 185)
    //        return button
    //    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.mainBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleLoginViews), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.mainBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleSignUpViews), for: .touchUpInside)
        return button
    }()
    
    private let creatorLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "Created by Allen Boynton 2019", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 13)!, NSAttributedString.Key.foregroundColor : UIColor.mainBlue])
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        textStackView.isHidden = true
        if !stackView.isHidden {
            userField.text = ""
            emailField.text = ""
            passwordField.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupStackView()
        handleAdRequest()
        self.hideKeyboardWhenTappedAround()
        self.moveKeyboard()
        userField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["email", "public_profile"]
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(bgImageView)
        view.addSubview(logoContainerView)
        view.addSubview(creatorLabel)
        logoContainerView.addSubview(logoImage)
        logoContainerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: logoImage.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
            
            logoContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            logoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            logoImage.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: logoContainerView.centerYAnchor, constant: -20),
            logoImage.heightAnchor.constraint(equalTo: logoContainerView.heightAnchor, multiplier: 0.25)
            ])
        
        creatorLabel.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 60, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    fileprivate func setupStackView() {
        textStackView = UIStackView(arrangedSubviews: [userField, emailField, passwordField, forgotButton, googleButton/*customFBLoginButton*/])
        textStackView.distribution = .fillEqually
        textStackView.spacing = 16
        textStackView.axis = .vertical
        
        buttonStackView = UIStackView(arrangedSubviews: [loginButton, signUpButton])
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 50
        
        //        socialMediaStack = UIStackView(arrangedSubviews: [fbLoginButton, googleButton])
        //        socialMediaStack.translatesAutoresizingMaskIntoConstraints = false
        //        socialMediaStack.distribution = .fillEqually
        
        stackView = UIStackView(arrangedSubviews: [textStackView, buttonStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 250),
            stackView.bottomAnchor.constraint(equalTo: creatorLabel.topAnchor, constant: 16)
            ])
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
    
    fileprivate func signUpTapped() {
        handleSignup()
    }
    
    fileprivate func loginTapped() {
        handleLogin()
    }
    
    @objc func handleLoginViews(_ sender: UIButton) {
        textStackView.isHidden = false
        userField.isHidden = true
        emailField.isHidden = false
        passwordField.isHidden = false
        forgotButton.isHidden = false
        signUpButton.setTitleColor(.lightGray, for: .normal)
        loginButton.setTitleColor(.mainBlue, for: .normal)
    }
    
    @objc func handleSignUpViews(_ sender: UIButton) {
        textStackView.isHidden = false
        userField.isHidden = false
        emailField.isHidden = false
        passwordField.isHidden = false
        forgotButton.isHidden = true
        loginButton.setTitleColor(.lightGray, for: .normal)
        signUpButton.setTitleColor(.mainBlue, for: .normal)
    }
    
    private func handleSignup() {
        guard let username = userField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil && user != nil {
                print("Success! Email: \(email), Password: \(password)")
                
                let menuView = self.storyboard?.instantiateViewController(withIdentifier: "MenuCollectionVC") as! MenuCollectionVC
                self.navigationController?.pushViewController(menuView, animated: true)
                
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
                    let menuView = self.storyboard?.instantiateViewController(withIdentifier: "MenuCollectionVC") as! MenuCollectionVC
                    self.navigationController?.pushViewController(menuView, animated: true)
                }
            })
        }
    }
    
    // Send a password reset email
    @objc fileprivate func forgotTapped() {
        // Alert to prompt user for email
        guard let email = emailField.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            print("Forgot password tapped: Sending email to reset!")
        }
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    @objc func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB login failed:", err as Any)
                return
            }
            //            self.customFBLoginButton.setTitle("Log out", for: .normal)
            //            self.customFBLoginButton.setTitleColor(.lightGray, for: .normal)
            self.showEmailAddress()
        }
    }
    
    fileprivate func showEmailAddress() {
        // Fetch email and profile info
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"])?.start(completionHandler: { (connection, result, err) in // picture.type(large)
            if err != nil {
                print("Failed to start Graph Request: ", err ?? "")
                return
            }
            print("Result: ", result ?? "")
            
            let accessToken = FBSDKAccessToken.current()
            guard let accessTokenString = accessToken?.tokenString else { return }
            let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            
            Auth.auth().signInAndRetrieveData(with: credentials) { (user, error) in
                if error != nil {
                    print("Something went wrong with our FB user: ", error ?? "")
                }
                if let user = Auth.auth().currentUser {
                    let userName = user.displayName
                    let email = user.email!
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userName
                    changeRequest?.commitChanges(completion: { (error) in
                        if error == nil {
                            print("User display name changed! User: \(userName ?? "")")
                            
                            let alert = UIAlertController(title: "Successfully Logged in with Facebook!", message: "Welcome \(userName ?? ""), Email: \(email)", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
                            
                            self.present(alert, animated: true)
                        }
                    })
                }
                print("Successfully logged in with our user: ", user ?? "")
            }
            
        })
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Failed to start graph request. Error: ", error)
        }
        showEmailAddress()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        FBSDKLoginManager().logOut()
        //        customFBLoginButton.setTitle("Login with Facebook", for: .normal)
        //        customFBLoginButton.setTitleColor(.white, for: .normal)
        print("Did log out of Facebook")
    }
}

extension LoginViewController: GADBannerViewDelegate {
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

extension LoginViewController: UITextFieldDelegate {
    //MARK: - Controlling the Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}

