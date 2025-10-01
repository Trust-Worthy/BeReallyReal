//
//  Login/LoginViewController.swift
//  BeReallyReal
//
//  Created by Trust-Worthy on 9/30/25.
//
import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Properties
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func onLoginTapped(_ sender: Any) {
        
        // Make sure all fields are non-nil and non-empty.
        guard let username = usernameField.text,
              let password = passwordField.text,
              !username.isEmpty,
              !password.isEmpty else {

            showMissingFieldsAlert()
            return
        }
        
        // Allow user to login to Back4App
        User.login(username: username, password: password) { [weak self] result in
            
            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")
                
                // Post a notification that the user has successfully logged in
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
            case .failure(let error):
                self?.showAlert(description: error.localizedDescription)
            }
            
        }
    }
    
    // MARK: - Alerts
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log in", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to log you in.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
