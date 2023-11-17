//
//  SignupViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-10-15.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class SignupViewController: UIViewController {
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
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    // Confirm Password input field
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the action for the loginButton
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)

       // Add subviews
       view.addSubview(emailTextField)
       view.addSubview(passwordTextField)
       view.addSubview(confirmPasswordTextField)
       view.addSubview(signupButton)

       // Set up constraints
       emailTextField.translatesAutoresizingMaskIntoConstraints = false
       passwordTextField.translatesAutoresizingMaskIntoConstraints = false
       signupButton.translatesAutoresizingMaskIntoConstraints = false
       confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false

       NSLayoutConstraint.activate([
           emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
           emailTextField.widthAnchor.constraint(equalToConstant: 200),
           emailTextField.heightAnchor.constraint(equalToConstant: 40),

           passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
           passwordTextField.widthAnchor.constraint(equalToConstant: 200),
           passwordTextField.heightAnchor.constraint(equalToConstant: 40),
           
           confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
           confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 200),
           confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),

           signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           signupButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
           signupButton.widthAnchor.constraint(equalToConstant: 200),
           signupButton.heightAnchor.constraint(equalToConstant: 40),
       ])
    }
    
    @objc func signupButtonTapped() {
        // Handle the login button tap here
        // Get the values from the text fields
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else {
            // Handle error if any of the fields is empty
            print("Please fill in all fields.")
            return
        }

        // Check if password and confirm password match
        guard password == confirmPassword else {
            print("Password and Confirm Password do not match.")
            showPasswordMismatchAlert()
            return
        }
        
        // Code for registering user - implement with data from input fields
        let authManager = AuthManager()
        let role = "STUDENT"
        
        authManager.registerUser(email: email, password: password, confirmPassword: confirmPassword, role: role) { [self] result in
            switch result {
            case .success(let data):
                print("registration successful")
                DispatchQueue.main.async {
                    // If login is successful, navigate to the "home" view controller
                    let vc = storyboard?.instantiateViewController(identifier: "home") as! UITabBarController
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print ("Registration failed with error: \(error)")
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Registration failed", message: "Unable to register. Please try again later.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Close", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    // Function to show a pop-up for password mismatch
    private func showPasswordMismatchAlert() {
        let alert = UIAlertController(title: "Error", message: "Password and Confirm Password do not match.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
