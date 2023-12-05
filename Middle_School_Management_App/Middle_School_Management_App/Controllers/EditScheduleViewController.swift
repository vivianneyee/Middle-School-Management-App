//
//  EditScheduleViewController.swift
//  Middle_School_Management_App
//
//  Created by Vivienne Cruz on 2023-11-14.
//

import Foundation
import UIKit
import ECWeekView
import SwiftDate
import RealmSwift

class EditScheduleViewController: UIViewController {
    
    private var enterNewPassText: UILabel = {
        let label = UILabel()
        label.text = "Enter new password:"
        return label
    }()
    
    // Password input field
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    // Login button
    private let submitNewPassButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Code for registering user - implement with data from input fields
//        let authManager = AuthManager()

        
//        authManager.registerUser(email: email, password: password, confirmPassword: confirmPassword, role: role) { result in
//            switch result {
//            case .success(let data):
//                print("registration successful")
//            case .failure(let error):
//                print ("Registration failed with error: \(error)")
//            }
//        }
//
        
        // Add the action for the loginButton
        submitNewPassButton.addTarget(self, action: #selector(submitNewPassButtonTapped), for: .touchUpInside)

       // Add subviews
       view.addSubview(enterNewPassText)
       view.addSubview(passwordTextField)
       view.addSubview(submitNewPassButton)

       // Set up constraints
       enterNewPassText.translatesAutoresizingMaskIntoConstraints = false
       passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        submitNewPassButton.translatesAutoresizingMaskIntoConstraints = false

       NSLayoutConstraint.activate([
        enterNewPassText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        enterNewPassText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
        enterNewPassText.widthAnchor.constraint(equalToConstant: 200),
        enterNewPassText.heightAnchor.constraint(equalToConstant: 20),

       passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
       passwordTextField.topAnchor.constraint(equalTo: enterNewPassText.bottomAnchor, constant: 20),
       passwordTextField.widthAnchor.constraint(equalToConstant: 200),
       passwordTextField.heightAnchor.constraint(equalToConstant: 40),

        submitNewPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        submitNewPassButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
        submitNewPassButton.widthAnchor.constraint(equalToConstant: 200),
        submitNewPassButton.heightAnchor.constraint(equalToConstant: 40),
       ])
    }
    
    @objc func submitNewPassButtonTapped() {
        print("button tapped")
        // Handle the new password tap here

        // If new password is successful, show pop up
        let alertController = UIAlertController(title: "Password changed", message: "Your password has been updated successfully.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default) { _ in
            // Handle action after the user taps "Okay" 
        }
        
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
