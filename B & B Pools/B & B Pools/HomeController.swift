//
//  ViewController.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/27/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import Fabric
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
//import SnapKit

// label.snp.makeConstraints { (maker) in
//    maker.centerX.centerY.equalToSuperView()
// }

class HomeController: UIViewController {
    
    private let vc = LoginViewController()
    private var stackView: UIStackView!
    private var buttonStackView: UIStackView!
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "POOLFINDER", attributes: [NSAttributedString.Key.font : UIFont(name: "Verdana-BoldItalic", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor.mainBlue])
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
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Vinyl Liner Pools", attributes: [NSAttributedString.Key.font : UIFont(name: "Verdana-BoldItalic", size: 18)!, NSAttributedString.Key.foregroundColor : UIColor.mainBlue])
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    private let mainImageView: UIImageView = {
        let imageName = "display1"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let signInGuest: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainBlue
        button.setTitle("Guest Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(signInAnonymously), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .mainBlue
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.mainBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 5.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.mainBlue.cgColor
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    private let creatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Created by Allen Boynton 2019", attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 13)!, NSAttributedString.Key.foregroundColor : UIColor.mainBlue])
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if Auth.auth().currentUser != nil {
            let menuView = MenuCollectionVC()
            navigationController?.pushViewController(menuView, animated: true)
        } else {
            //User Not logged in
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupStackView()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(bgImageView)
        view.addSubview(logoContainerView)
        view.addSubview(creatorLabel)
        logoContainerView.addSubview(logoImage)
        logoContainerView.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(mainImageView)
        
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
            logoImage.heightAnchor.constraint(equalTo: logoContainerView.heightAnchor, multiplier: 0.18),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainImageView.topAnchor, constant: 10),
            
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            mainImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.225),
            
            creatorLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            creatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            creatorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func setupStackView() {
        buttonStackView = UIStackView(arrangedSubviews: [signInGuest, signUpButton, loginButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 16
        buttonStackView.axis = .vertical
        
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: creatorLabel.topAnchor, constant: -60),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2) //0.12)
            ])
    }
    
    @objc private func signInAnonymously() {
        Auth.auth().signInAnonymously() { (authResult, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                let user = authResult?.user
                let isAnonymous = user?.isAnonymous  // true
                let uid = user?.uid
                print("User: ", user ?? "")
                print("isAnonymous: ", isAnonymous ?? "")
                print("UID: ", uid ?? "")
                let mainMenuVC = MenuCollectionVC()
                self.navigationController?.pushViewController(mainMenuVC, animated: true)
            }
        }
    }
    
    @objc private func tappedSignUpButton() {
        loginVsSignup = 1
        print(loginVsSignup)
        segueToLoginScreen()
    }
    
    @objc private func tappedLoginButton() {
        loginVsSignup = 2
        print(loginVsSignup)
        segueToLoginScreen()
    }
    
    private func segueToLoginScreen() {
         //your view controller
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
