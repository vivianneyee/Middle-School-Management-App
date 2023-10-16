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
//    @IBOutlet weak var dateTF: UITextField!
//    var postTitle: String?
//    var postDate: String?
    
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
    
//    @IBAction func tapToHomePage(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(identifier: "home") as! UITabBarController
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the action for the loginButton
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)

       // Add subviews
       view.addSubview(emailTextField)
       view.addSubview(passwordTextField)
       view.addSubview(signupButton)

       // Set up constraints
       emailTextField.translatesAutoresizingMaskIntoConstraints = false
       passwordTextField.translatesAutoresizingMaskIntoConstraints = false
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

           signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
           signupButton.widthAnchor.constraint(equalToConstant: 200),
           signupButton.heightAnchor.constraint(equalToConstant: 40),
       ])
    }
    
    @objc func signupButtonTapped() {
        print("button tapped")
        // Handle the login button tap here

        // If login is successful, navigate to the "home" view controller
        let vc = storyboard?.instantiateViewController(identifier: "home") as! UITabBarController
//        navigationController?.pushViewController(vc, animated: true)
        // add sign up logic
        vc.modalPresentationStyle = .fullScreen  // Optional: Set the presentation style
        present(vc, animated: true, completion: nil)
    }
}
