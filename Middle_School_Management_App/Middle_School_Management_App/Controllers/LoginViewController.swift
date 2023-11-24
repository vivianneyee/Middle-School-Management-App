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
        textField.placeholder = "Email"
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
    private let signupLink: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
        label.textColor = .systemBlue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the action for the loginButton
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Add the action for the sign up link
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(signupLinkTapped))
        signupLink.addGestureRecognizer(tapGesture)
        signupLink.isUserInteractionEnabled = true

       // Add subviews
       view.addSubview(emailTextField)
       view.addSubview(passwordTextField)
       view.addSubview(loginButton)
       view.addSubview(signupLink)

       // Set up constraints
       emailTextField.translatesAutoresizingMaskIntoConstraints = false
       passwordTextField.translatesAutoresizingMaskIntoConstraints = false
       loginButton.translatesAutoresizingMaskIntoConstraints = false
       signupLink.translatesAutoresizingMaskIntoConstraints = false

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
           
           signupLink.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           signupLink.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
           signupLink.widthAnchor.constraint(equalToConstant: 200),
           signupLink.heightAnchor.constraint(equalToConstant: 40)
       ])
    }
    
    @objc func loginButtonTapped() {
        print("button tapped")
        // Handle the login button tap here
        // Get the values from the text fields
        guard let email = emailTextField.text,
        let password = passwordTextField.text else {
        // Handle error if any of the fields is empty
        print("Please fill in all fields.")
        return
        }
        // Code for logging in user - implement with data from input fields
        let authManager = AuthManager()
        authManager.loginUser(email: email, password: password) { [self] result in
            switch result {
            case .success(let data):
                print("Login successful")
                DispatchQueue.main.async {
                    // If login is successful, navigate to the "home" view controller
                    let vc = self.storyboard?.instantiateViewController(identifier: "home") as! CustomTabBarController
                    // add sign in logic
                    vc.modalPresentationStyle = .fullScreen
                    // pass the user id to the next storyboard
                     vc.userID = data._id
                    self.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print ("Login failed with error: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Login failed", message: "Unable to login. Please try again later.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Close", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func signupLinkTapped() {
        print("button tapped")
        // Handle the login button tap here

        // If login is successful, navigate to the "home" view controller
        let vc = storyboard?.instantiateViewController(identifier: "signup") as! SignupViewController
        navigationController?.pushViewController(vc, animated: true)
    }

}
