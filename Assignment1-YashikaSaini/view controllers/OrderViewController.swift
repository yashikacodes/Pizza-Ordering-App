//
//  OrderViewController.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 2/8/25.
//

import UIKit

class OrderViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var deliveryDatePicker: UIDatePicker!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var sizeSegmentControl: UISegmentedControl!

    // Meat Toppings Switches
    @IBOutlet var meatSwitch1: UISwitch!
    @IBOutlet var meatSwitch2: UISwitch!
    @IBOutlet var meatSwitch3: UISwitch!
    
    // Vegetable Toppings Switches
    @IBOutlet var vegetableSwitch1: UISwitch!
    @IBOutlet var vegetableSwitch2: UISwitch!
    @IBOutlet var vegetableSwitch3: UISwitch!

    // Avatar Selection
    @IBOutlet var avatarImageView1: UIImageView!
    @IBOutlet var avatarImageView2: UIImageView!
    @IBOutlet var avatarImageView3: UIImageView!
    
    let avatarImages = ["avatar1", "avatar2", "avatar3"] // Image names in Assets
    var selectedAvatar: String = "avatar1" // Default to "avatar1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    // Detect touch on avatar images
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self.view)

            // Detect touch on avatar images and update the selectedAvatar string
            if avatarImageView1.frame.contains(touchPoint) {
                selectedAvatar = "avatar1"
            } else if avatarImageView2.frame.contains(touchPoint) {
                selectedAvatar = "avatar2"
            } else if avatarImageView3.frame.contains(touchPoint) {
                selectedAvatar = "avatar3"
            }
        }
    }

    @IBAction func placeOrderPressed(_ sender: UIButton) {
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        let order = OrderData()
        
        // Collect order details
        let date = deliveryDatePicker.date.description
        let address = addressTextField.text ?? "No Address"
        let size = sizeSegmentControl.selectedSegmentIndex
        
        // Collect selected meat toppings
        var meatToppings: [String] = []
        if meatSwitch1.isOn { meatToppings.append("Chicken") }
        if meatSwitch2.isOn { meatToppings.append("Beef") }
        if meatSwitch3.isOn { meatToppings.append("Pork") }
        let meatToppingsString = meatToppings.isEmpty ? "None" : meatToppings.joined(separator: ", ")

        // Collect selected vegetable toppings
        var vegetableToppings: [String] = []
        if vegetableSwitch1.isOn { vegetableToppings.append("Carrot") }
        if vegetableSwitch2.isOn { vegetableToppings.append("Cucumber") }
        if vegetableSwitch3.isOn { vegetableToppings.append("Spinach") }
        let vegetableToppingsString = vegetableToppings.isEmpty ? "None" : vegetableToppings.joined(separator: ", ")

        // Use the selected avatar (as a string)
        let avatar = selectedAvatar

        // Initialize order data
        order.initWithData(
            id: 0,
            date: date,
            address: address,
            size: size,
            meatToppings: meatToppingsString,
            vegToppings: vegetableToppingsString, avatar: avatar
        )

        // Save to database and show confirmation
        if mainDelegate.insertIntoDatabase(order: order) {
            let alert = UIAlertController(title: "Success", message: "Order placed successfully!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true)
            })
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Failed to save order.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

}
