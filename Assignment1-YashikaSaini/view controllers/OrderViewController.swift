//
//  OrderViewController.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 2/8/25.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet var deliveryDatePicker: UIDatePicker!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var sizeSegmentControl: UISegmentedControl!
    @IBOutlet var meatToppingsSwitch: UISwitch!
    @IBOutlet var vegetableToppingsSwitch: UISwitch!
    
    @IBAction func placeOrderPressed(_ sender: UIButton) {
        let date = deliveryDatePicker.date
        let address = addressTextField.text ?? "No Address"
        let size = sizeSegmentControl.titleForSegment(at: sizeSegmentControl.selectedSegmentIndex) ?? "Unknown"
        let meatToppings = meatToppingsSwitch.isOn ? "Yes" : "No"
        let vegetableToppings = vegetableToppingsSwitch.isOn ? "Yes" : "No"

        let message = """
        Delivery Date: \(date)
        Address: \(address)
        Pizza Size: \(size)
        Meat Toppings: \(meatToppings)
        Vegetable Toppings: \(vegetableToppings)
        """

        let alert = UIAlertController(title: "Order Summary", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true)
        }
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
    
    
    
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
