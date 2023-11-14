//
//  LoginViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
//import RealmSwift

class LoginViewController: UIViewController {
    // Email or username input field
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or Username"
        textField.borderStyle = .roundedRect
        return textField
    }()

    // Password input field
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    // Login button
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    // Link to signup
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create an account", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .clear
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the action for the loginButton
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Add the action for the sign up link
        signupButton.addTarget(self, action: #selector(signupLinkTapped), for: .touchUpInside)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signupLinkTapped))
//        signupLink.addGestureRecognizer(tapGesture)
//        signupLink.isUserInteractionEnabled = true

       // Add subviews
       view.addSubview(emailTextField)
       view.addSubview(passwordTextField)
       view.addSubview(loginButton)
       view.addSubview(signupButton)

       // Set up constraints
       emailTextField.translatesAutoresizingMaskIntoConstraints = false
       passwordTextField.translatesAutoresizingMaskIntoConstraints = false
       loginButton.translatesAutoresizingMaskIntoConstraints = false
       signupButton.translatesAutoresizingMaskIntoConstraints = false

       NSLayoutConstraint.activate([
           emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
           emailTextField.widthAnchor.constraint(equalToConstant: 200),
           emailTextField.heightAnchor.constraint(equalToConstant: 40),

           passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
           passwordTextField.widthAnchor.constraint(equalToConstant: 200),
           passwordTextField.heightAnchor.constraint(equalToConstant: 40),

           loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
           loginButton.widthAnchor.constraint(equalToConstant: 200),
           loginButton.heightAnchor.constraint(equalToConstant: 40),
           
           signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
           signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 5),
           signupButton.widthAnchor.constraint(equalToConstant: 200),
           signupButton.heightAnchor.constraint(equalToConstant: 40)
       ])
    }
    
    @objc func loginButtonTapped() {
        print("button tapped")
        // Handle the login button tap here

        // If login is successful, navigate to the "home" view controller
        let vc = storyboard?.instantiateViewController(identifier: "home") as! UITabBarController
        // add sign in logic
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func signupLinkTapped() {
        print("button tapped")
        // Handle the login button tap here

        // If login is successful, navigate to the "home" view controller
        let vc = storyboard?.instantiateViewController(identifier: "signup") as! SignupViewController
        vc.modalPresentationStyle = .popover
        present(vc, animated: true, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
    }

}
