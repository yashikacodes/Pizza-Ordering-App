//
//  OrderData.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 3/19/25.
//

import UIKit

class OrderData: NSObject {

    var id: Int?
    var deliveryDate: String?
    var address: String?
    var size: Int?
    var meatToppings: String?
    var vegToppings: String?
        
    func initWithData(id: Int, date: String, address: String, size: Int, meatToppings: String, vegToppings: String) {
        self.id = id
        self.deliveryDate = date
        self.address = address
        self.size = size
        self.meatToppings = meatToppings
        self.vegToppings = vegToppings
    }
}

