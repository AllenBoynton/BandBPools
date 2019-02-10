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

class LoginViewController: UIViewController, GIDSignInUIDelegate {
    
    private var bannerView: GADBannerView!
    private var stackView: UIStackView!
    private let menuView = MenuCollectionVC()
    
    private let bgImageView: UIImageView = {
        let imageName = "bg"
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
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Username"
        field.autocapitalizationType = .none
        field.backgroundColor = .clear
        field.layer.cornerRadius = 5.0
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.mainBlue.cgColor
        field.returnKeyType = .next
        field.keyboardType = .default
        return field
    }()
    
    private let emailField: UITextFieldPadding = {
        let field = UITextFieldPadding()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Email Address"
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
        field.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 2)
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let dividerLine2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 2)
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let connectWithLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Or Connect With", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue", size: 16)!, NSAttributedString.Key.foregroundColor : UIColor.black])
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
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
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .mainBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainBlue
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let fbLoginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let googleButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        // Unhides nav bar and makes items white
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.tintColor = .white
        
        handleLoginOrSignUp(num: loginVsSignup)
        print(loginVsSignup)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupStackViewLayout()
        handleAdRequest()
        hideKeyboardWhenTappedAround()
//        self.moveKeyboard()
        emailField.delegate = self
        passwordField.delegate = self
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["email", "public_profile"]
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
    
    private func handleLoginOrSignUp(num: UInt) {
        switch num {
        case 1:
            self.title = "Sign Up"
            userField.delegate = self
            loginButton.isHidden = true
            forgotButton.isHidden = true
            userField.isHidden = false
            signUpButton.isHidden = false
        case 2:
            self.title = "Log In"
            userField.isHidden = true
            signUpButton.isHidden = true
            forgotButton.isHidden = false
            loginButton.isHidden = false
        default:
            print("Page setup error")
            break
        }
    }
    
    private func setupLayout() {
        view.addSubview(bgImageView)
        view.addSubview(logoContainerView)
        logoContainerView.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            logoContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            logoImage.centerYAnchor.constraint(equalTo: logoContainerView.centerYAnchor, constant: 0),
            logoImage.centerXAnchor.constraint(equalTo: logoContainerView.centerXAnchor, constant: 0),
            logoImage.widthAnchor.constraint(equalTo: logoContainerView.widthAnchor, multiplier: 0.6),
            logoImage.heightAnchor.constraint(equalTo: logoContainerView.heightAnchor, multiplier: 0.3)
            ])
    }
    
    private func setupStackViewLayout() {
        stackView = UIStackView(arrangedSubviews: [userField, emailField, passwordField, loginButton, forgotButton, signUpButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        view.addSubview(dividerLine)
        view.addSubview(connectWithLabel)
        view.addSubview(dividerLine2)
        view.addSubview(fbLoginButton)
        view.addSubview(googleButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            
            dividerLine.heightAnchor.constraint(equalToConstant: 2),
            dividerLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            dividerLine.trailingAnchor.constraint(equalTo: connectWithLabel.leadingAnchor, constant: 0),
            dividerLine.centerYAnchor.constraint(equalTo: connectWithLabel.centerYAnchor),
            
            connectWithLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            connectWithLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectWithLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5),
            connectWithLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dividerLine2.heightAnchor.constraint(equalToConstant: 2),
            dividerLine2.leadingAnchor.constraint(equalTo: connectWithLabel.trailingAnchor, constant: 0),
            dividerLine2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            dividerLine2.centerYAnchor.constraint(equalTo: connectWithLabel.centerYAnchor),

            fbLoginButton.topAnchor.constraint(equalTo: connectWithLabel.bottomAnchor, constant: 16),
            fbLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            fbLoginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1.0),
//            fbLoginButton.heightAnchor.constraint(equalToConstant: 28),
            
            googleButton.topAnchor.constraint(equalTo: fbLoginButton.bottomAnchor, constant: 16),
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)//,
//            googleButton.widthAnchor.constraint(equalTo: fbLoginButton.widthAnchor, constant: 10),
//            googleButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser != nil {
//
//        }
    }
    
    @objc private func handleSignup() {
        guard let username = userField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        if password.isEmpty == false && email.isEmpty == false && username.isEmpty == false {
            if isValidEmail(testStr: emailField.text!) {
                //email is valid
                if ((passwordField.text?.count)!) >= 6 && ((passwordField.text?.count)!) <= 12 {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error == nil && user != nil {
                            print("Success! Email: \(email), Password: \(password)")
                            self.navigationController?.pushViewController(self.menuView, animated: true)
                            
//                            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                            changeRequest?.displayName = username
//                            changeRequest?.commitChanges(completion: { (error) in
//                                if error == nil {
//                                    print("User display name changed! User: \(username)")
//                                }
//                            })
                        } else {
                            print("Error: \(error!.localizedDescription)")
                        }
                    })
                } else {
                    isInvalidPasswordAlert()
                }
            } else {
                isInvalidEmailAlert()
            }
        } else {
            isEmptyFieldAlert()
        }
    }
    
    @objc private func handleLogin() {
        if passwordField.text?.isEmpty == false && emailField.text?.isEmpty == false {
            if isValidEmail(testStr: emailField.text!) {
                //email is valid
                if ((passwordField.text?.count)!) >= 6 && ((passwordField.text?.count)!) <= 12 {
                    if let email = emailField.text, let password = passwordField.text {
                        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                            if let firebaseError = error {
                                print("Error: \(firebaseError.localizedDescription)")
                                return
                            } else {
                                print("Success! Email: \(email), Password: \(password)")
                                self.navigationController?.pushViewController(self.menuView, animated: true)
                            }
                        })
                    }
                } else {
                    isInvalidPasswordAlert()
                }
            } else {
                isInvalidEmailAlert()
            }
        } else {
            isEmptyFieldAlert()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func isEmptyFieldAlert() {
        let emptyFieldAlert = UIAlertController(title: "Invalid Entries", message: "Please enter a valid address and password", preferredStyle: .alert)
        emptyFieldAlert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        //PRESENT ALERT
        self.present(emptyFieldAlert, animated: true, completion: nil)
    }
    
    func isInvalidEmailAlert() {
        let invalidEntryAlert = UIAlertController(title: "Invalid E-Mail Address", message: "Please enter a valid address", preferredStyle: .alert)
        invalidEntryAlert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        //PRESENT ALERT
        self.present(invalidEntryAlert, animated: true, completion: nil)
    }
    
    func isInvalidPasswordAlert() {
        let invalidPasswordAlert = UIAlertController(title: "Invalid Password", message: "Please enter a valid password between 6 and 12 characters", preferredStyle: .alert)
        invalidPasswordAlert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: nil))
        //PRESENT ALERT
        self.present(invalidPasswordAlert, animated: true, completion: nil)
    }
    
    // Send a password reset email
    @objc fileprivate func forgotTapped() {
        let forgotPasswordAlert = UIAlertController(title: "Forgot your password?", message: "Enter email address", preferredStyle: .alert)
        forgotPasswordAlert.addTextField { (textField) in
            textField.placeholder = "Enter email address"
        }
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler: { (action) in
            let resetEmail = forgotPasswordAlert.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: resetEmail!, completion: { (error) in
                DispatchQueue.main.async {
                    //Use "if let" to access the error, if it is non-nil
                    if let error = error {
                        let resetFailedAlert = UIAlertController(title: "Reset Failed", message: error.localizedDescription, preferredStyle: .alert)
                        resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(resetFailedAlert, animated: true, completion: nil)
                    } else {
                        let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                        resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(resetEmailSentAlert, animated: true, completion: nil)
                    }
                }
            })
        }))
        //PRESENT ALERT
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    
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
                } else {
//                if let user = Auth.auth().currentUser {
//                    let userName = user.displayName
//                    let email = user.email!
//
//                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
//                    changeRequest?.displayName = userName
//                    changeRequest?.commitChanges(completion: { (error) in
//                        if error == nil {
//                            print("User display name changed! User: \(userName ?? "")")
//
//                            let alert = UIAlertController(title: "Successfully Logged in with Facebook!", message: "Welcome \(userName ?? ""), Email: \(email)", preferredStyle: .alert)
//
//                            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
//
//                            self.present(alert, animated: true)
//                        }
//                    })
//                }
                    self.navigationController?.pushViewController(self.menuView, animated: true)
                    print("Successfully logged in with our user: ", user ?? "")
                }
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

