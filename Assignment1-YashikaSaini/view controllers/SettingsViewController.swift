//
//  SettingsViewController.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 2/8/25.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // Function to remember entered data in UserDefaults
    func rememberEnteredData() {
        let defaults = UserDefaults.standard
        defaults.set(nameTextField.text, forKey: "lastName")
        defaults.set(emailTextField.text, forKey: "lastEmail")
        defaults.set(phoneNumberTextField.text, forKey: "lastPhone")
        defaults.synchronize()
    }

    // Function to load saved data from UserDefaults
    func loadSavedData() {
        let defaults = UserDefaults.standard
        
        if let savedName = defaults.string(forKey: "lastName") {
            nameTextField.text = savedName
        }
        if let savedEmail = defaults.string(forKey: "lastEmail") {
            emailTextField.text = savedEmail
        }
        if let savedPhone = defaults.string(forKey: "lastPhone") {
            phoneNumberTextField.text = savedPhone
        }
    }
    
    @IBAction func unwindToSettings(sender: UIStoryboardSegue) { }

    @IBAction func submitPressed(_ sender: UIButton) {
        let name = nameTextField.text ?? "No Name"
        let email = emailTextField.text ?? "No Email"
        let phone = phoneNumberTextField.text ?? "No Phone"

        // Save data to UserDefaults when the submit button is pressed
        rememberEnteredData()
        
        let message = """
        Name: \(name)
        Email: \(email)
        Phone: \(phone)
        """
        
        let alert = UIAlertController(title: "Your Details", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load saved data when the view loads
        loadSavedData()
    }

}
