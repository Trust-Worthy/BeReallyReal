//
//  Login/SignUpViewController.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 9/30/25.
//

import UIKit
import ParseSwift

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func onSignUpTapped(_ sender: Any) {
        
        // make sure all fields are non-nil and non-empty
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty else {
            
            showMissingFieldsAlert()
            return
        }
        
        // Parse user sign up
        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password
        
        newUser.signup { [weak self] result in
            
            switch result {
            case .success(let user):
                print("Successfully signed up user \(user)")
                
                // Post a notification that the user has successfully signed up
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                // Failed sign up
                self?.showAlert(description: error.localizedDescription)
            }
            
        }
    }
    
    
    
    // MARK: - Alerts
    
    /// Alert used when there is a general error
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    /// Alert used when there are missing fields for the users sign up submission
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
