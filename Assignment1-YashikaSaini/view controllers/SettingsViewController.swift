//
//  SettingsViewController.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 2/8/25.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    
    @IBAction func unwindToSettings(sender: UIStoryboardSegue) { }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        let name = nameTextField.text ?? "No Name"
        let email = emailTextField.text ?? "No Email"
        let phone = phoneNumberTextField.text ?? "No Phone"

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
    
    // Unwind Segue - Called when Back Button is pressed
    @IBAction func unwindToMain(sender: UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
