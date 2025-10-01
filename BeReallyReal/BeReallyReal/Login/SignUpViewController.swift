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
