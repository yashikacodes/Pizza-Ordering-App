//
//  OrderHistoryViewController.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 3/20/25.
//

import UIKit

class OrderHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView : UITableView!
    
    //var orders: [OrderData] = []
    
    // Load orders from database
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //orders = appDelegate.orders
        
        //print("Orders loaded:", orders)
        
        //reference: https://www.hackingwithswift.com/example-code/uikit/how-to-put-a-background-picture-behind-uitableviewcontroller
        
        myTableView.backgroundView = UIImageView(image: UIImage(named: "backgroundimageassign2"))
        
        appDelegate.readDataFromDatabase()
        
        myTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = appDelegate.orders[indexPath.row]
        
        let tableCell: OrderCell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell ?? OrderCell(style: .default, reuseIdentifier: "OrderCell")
        
        
        tableCell.primaryLabel.text = order.deliveryDate
        tableCell.secondaryLabel.text = order.address
        
        // Set the avatar image based on the order's avatar
        if let avatar = order.avatar, let image = UIImage(named: avatar) {
            tableCell.avatarImage.image = image
        } else {
            tableCell.avatarImage.image = UIImage(named: "defaultAvatar")
        }
        
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let order = appDelegate.orders[indexPath.row]
        
        let sizeText: String
        switch order.size {
        case 0: sizeText = "Small"
        case 1: sizeText = "Medium"
        case 2: sizeText = "Large"
        default: sizeText = "Unknown"
        }

        
        // Show all order details in an alert
        let alertController = UIAlertController(title: "Order Details", message: """
        Order ID: \(order.id ?? 0)
        Date & Time: \(order.deliveryDate ?? "")
        Address: \(order.address ?? "")
        Size: \(sizeText)
        Meat Toppings: \(order.meatToppings ?? "")
        Veg Toppings: \(order.vegToppings ?? "")
        """, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
