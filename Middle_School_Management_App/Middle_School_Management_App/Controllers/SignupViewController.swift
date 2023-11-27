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

class SignupViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    // user type input field
    private let userTypeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Select user type"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let userTypePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let options = ["Admin", "Teacher", "Student"]
    
    // Email or username input field
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    // email error label
    private let emailErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    // Password input field
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        return textField
    }()
    
    // password error label
    private let passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 10)
        return label
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
        textField.autocapitalizationType = .none
        return textField
    }()
    
    // confirm password error label
    private let confirmPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Add the action for the loginButton
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        emailTextField.delegate = self
        userTypePickerView.delegate = self
        userTypeTextField.inputView = userTypePickerView

       // Add subviews
       view.addSubview(userTypeTextField)
       view.addSubview(emailTextField)
       view.addSubview(emailErrorLabel)
       view.addSubview(passwordErrorLabel)
       view.addSubview(confirmPasswordErrorLabel)
       view.addSubview(passwordTextField)
       view.addSubview(confirmPasswordTextField)
       view.addSubview(signupButton)

       // Set up constraints
       userTypeTextField.translatesAutoresizingMaskIntoConstraints = false
       emailTextField.translatesAutoresizingMaskIntoConstraints = false
       emailErrorLabel.translatesAutoresizingMaskIntoConstraints = false
       passwordTextField.translatesAutoresizingMaskIntoConstraints = false
       passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
       signupButton.translatesAutoresizingMaskIntoConstraints = false
       confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
       confirmPasswordErrorLabel.translatesAutoresizingMaskIntoConstraints = false

       NSLayoutConstraint.activate([
            userTypeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userTypeTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            userTypeTextField.widthAnchor.constraint(equalToConstant: 200),
            userTypeTextField.heightAnchor.constraint(equalToConstant: 40),
            
           emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           emailTextField.topAnchor.constraint(equalTo: userTypeTextField.bottomAnchor, constant: 20),
           emailTextField.widthAnchor.constraint(equalToConstant: 200),
           emailTextField.heightAnchor.constraint(equalToConstant: 40),
           
           emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2),
           emailErrorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
           emailErrorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
           emailErrorLabel.heightAnchor.constraint(equalToConstant: 20),

           passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
           passwordTextField.widthAnchor.constraint(equalToConstant: 200),
           passwordTextField.heightAnchor.constraint(equalToConstant: 40),
           
           passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 2),
           passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
           passwordErrorLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
           passwordErrorLabel.heightAnchor.constraint(equalToConstant: 20),
           
           confirmPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
           confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 200),
           confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
           
           confirmPasswordErrorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 2),
           confirmPasswordErrorLabel.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor),
           confirmPasswordErrorLabel.trailingAnchor.constraint(equalTo: confirmPasswordTextField.trailingAnchor),
           confirmPasswordErrorLabel.heightAnchor.constraint(equalToConstant: 20),
           
           signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           signupButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
           signupButton.widthAnchor.constraint(equalToConstant: 200),
           signupButton.heightAnchor.constraint(equalToConstant: 40),
       ])
    }
    
    // MARK: - UIPickerViewDataSource

    // Number of components in the picker view (columns)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // Number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    // MARK: - UIPickerViewDelegate

    // Title for each row in the picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    // Handle selection in the picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userTypeTextField.text = options[row]
        userTypeTextField.resignFirstResponder() // Hide the picker view after selection
    }
    
    @objc func signupButtonTapped() {
        // Handle the login button tap here
        // Get the values from the text fields
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text,
              let userType = userTypeTextField.text else {
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
        
        authManager.registerUser(email: email, password: password, confirmPassword: confirmPassword, role: userType) { [self] result in
            switch result {
            case .success(let data):
                print("registration successful")
                DispatchQueue.main.async {
                    // If login is successful, navigate to the "home" view controller
                    let vc = self.storyboard?.instantiateViewController(identifier: "home") as! CustomTabBarController
                    vc.modalPresentationStyle = .fullScreen
                    vc.userID = data._id
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            // Validate email on each change
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            validateEmail(text: newText)
        }

        if textField == passwordTextField {
            // validate password on each change
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            validatePassword(text: newText)
        }
        
        if textField == confirmPasswordTextField {
            // validate the confirm password field
            let currentText = (textField.text ?? "") as NSString
            let newText = currentText.replacingCharacters(in: range, with: string)
            validateConfirmPassword(text: newText)
        }

        return true
    }

    func validateEmail(text: String) {
        if text.isValidEmail() {
            emailErrorLabel.isHidden = true // Hide error message if email is valid
            emailTextField.textColor = .black // Reset text color
        } else {
            emailErrorLabel.isHidden = false // Show error message
            emailErrorLabel.text = "Invalid email format" // Set error message text
            emailTextField.textColor = .red // Change text color to indicate error
        }
    }
    
    func validatePassword(text: String) {
        if text.isValidPassword() {
            passwordErrorLabel.isHidden = true // Hide error message if email is valid
            passwordTextField.textColor = .black // Reset text color
        } else {
            passwordErrorLabel.isHidden = false // Show error message
            passwordErrorLabel.text = "Invalid password format" // Set error message text
            passwordTextField.textColor = .red // Change text color to indicate error
        }
    }
    
    func validateConfirmPassword(text: String) {
        if text.isValidConfirmPassword(password: passwordTextField.text ?? "") {
            // Passwords match
            confirmPasswordErrorLabel.isHidden = true
            confirmPasswordTextField.textColor = .black
        } else {
            // Passwords don't match
            confirmPasswordErrorLabel.isHidden = false
            confirmPasswordErrorLabel.text = "Passwords do not match"
            confirmPasswordTextField.textColor = .red
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

extension String {
    func isValidEmail() -> Bool {
        // Regular expression pattern for email validation
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    func isValidPassword() -> Bool {
        // Password requirements:
        // At least 6 characters, one uppercase letter, one lowercase letter, one number, and one special character
        // change to actual regex
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
    func isValidConfirmPassword(password: String) -> Bool {
        return self == password
    }
}
