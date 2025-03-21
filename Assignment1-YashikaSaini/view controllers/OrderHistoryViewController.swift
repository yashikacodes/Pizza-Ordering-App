//
//  OrderHistoryViewController.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 3/20/25.
//

import UIKit

class OrderHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var orders: [OrderData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setTableViewBackgroundImage()
        
        // Load orders from database
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        orders = appDelegate.orders
        tableView.reloadData()
        
        // Set the table view delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")

        
        // Set background image
        //tableView.backgroundView = UIImageView(image: UIImage(named: "backgroundImage"))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderCell
        
        // Display limited information
        tableCell.primaryLabel.text = order.deliveryDate
        tableCell.secondaryLabel.text = order.address
        
        // Set the avatar image based on the order's avatar
        if let avatar = order.avatar, let image = UIImage(named: avatar) {
            tableCell.avatarImageView.image = image
        } else {
            tableCell.avatarImageView.image = UIImage(named: "defaultAvatar")
        }
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        
        // Show all order details in an alert
        let alertController = UIAlertController(title: "Order Details", message: """
        Order ID: \(order.id ?? 0)
        Date: \(order.deliveryDate ?? "")
        Address: \(order.address ?? "")
        Size: \(order.size ?? 0)
        Meat Toppings: \(order.meatToppings ?? "")
        Veg Toppings: \(order.vegToppings ?? "")
        """, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //func setTableViewBackgroundImage() {
        // Set the background image of the table view
        //let backgroundImage = UIImage(named: "backgroundimageassign2") // Add your image name here
        //let imageView = UIImageView(image: backgroundImage)
        
        // Make sure the image stretches to fill the entire table view
        //imageView.contentMode = .scaleToFill
        
        // Set the image view as the background view for the table view
        //tableView.backgroundView = imageView
    //}
}
