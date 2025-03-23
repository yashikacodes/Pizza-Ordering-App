//
//  AppDelegate.swift
//  Assignment1-YashikaSaini
//
//  Created by Default User on 2/8/25.
//

import UIKit
import SQLite3

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var databaseName : String = "myorders.db"
    var databasePath : String = ""
    var orders: [OrderData] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName)

        checkAndCreateDatabase()
        readDataFromDatabase()
        
        return true
    }

    func checkAndCreateDatabase() {
        var success = false
        let fm = FileManager.default
        
        success = fm.fileExists(atPath: databasePath)
        
        if success {return}

        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName)
        try? fm.copyItem(atPath: databasePathFromApp!, toPath: databasePath)
        
        return
    }

    func readDataFromDatabase() {
        orders.removeAll()
        var db: OpaquePointer? = nil

        if sqlite3_open(databasePath, &db) == SQLITE_OK {
            print("Successfully opened db at \(databasePath)")
            let queryStatementString : String = "select * from orders"
            var queryStatement: OpaquePointer? = nil

            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cdate = sqlite3_column_text(queryStatement, 1)
                    let caddress = sqlite3_column_text(queryStatement, 2)
                    let cmeatToppings = sqlite3_column_text(queryStatement, 4)
                    let cvegToppings = sqlite3_column_text(queryStatement, 5)
                    let cavatar = sqlite3_column_text(queryStatement, 6)
                    
                    let date = String(cString: cdate!)
                    
                    let address = String(cString: caddress!)
                
                    let size = Int(sqlite3_column_int(queryStatement, 3))
                    let meatToppings = String(cString: cmeatToppings!)
                    let vegToppings = String(cString: cvegToppings!)
                    let avatar = String(cString: cavatar!)
                    
                    

                    let order : OrderData = .init()
                    
                    order.initWithData(id: id, date: date, address: address, size: size, meatToppings: meatToppings, vegToppings: vegToppings, avatar: avatar)
                    
                    orders.append(order)
                    print("Results: ")
                    print("\(id) | \(date) | \(address) | \(size) | \(meatToppings) | \(vegToppings) | \(avatar)")
                }
                
                sqlite3_finalize(queryStatement)
            }else{
                print("Select statement couldn't be prepared. \(String(cString: sqlite3_errmsg(db)))")
            }
            sqlite3_close(db)
        }else{
            print("Unable to open database.")
        }
    }

    func insertIntoDatabase(order: OrderData) -> Bool {
        var db: OpaquePointer? = nil
        var returnCode : Bool = true

        if sqlite3_open(databasePath, &db) == SQLITE_OK {
            
            print("Successfully opened Database.")
            
            let insertStatementString = "INSERT INTO orders VALUES (NULL, ?, ?, ?, ?, ?, ?)" // Updated to include avatar
            var insertStatement: OpaquePointer? = nil

            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                
                let deliveryDate = order.deliveryDate! as NSString
                let address = order.address! as NSString
                let meatToppings = order.meatToppings! as NSString
                let vegToppings = order.vegToppings! as NSString
                let avatar = order.avatar! as NSString
                
                
                sqlite3_bind_text(insertStatement, 1, deliveryDate.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, address.utf8String, -1, nil)
                sqlite3_bind_int(insertStatement, 3, Int32(order.size!))
                sqlite3_bind_text(insertStatement, 4, meatToppings.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, vegToppings.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, avatar.utf8String, -1, nil) // Bind the avatar string

                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowId = sqlite3_last_insert_rowid(db)
                    print("Insert statement worked with row: \(rowId)")
                }else{
                    print("Couldn't insert \(String(cString: sqlite3_errmsg(db)))")
                    returnCode = false
                }
                sqlite3_finalize(insertStatement)
            }else{
                print("Insert statement couldn't be prepared. \(String(cString: sqlite3_errmsg(db)))")
                returnCode = false
            }
            sqlite3_close(db)
        }else{
            print("Couldn't Open")
            returnCode = false
        }
        return returnCode
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Release any resources that were specific to the discarded scenes.
    }
    
    
}
