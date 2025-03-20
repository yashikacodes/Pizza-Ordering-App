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
    
    var databaseName = "orders.db"
        var databasePath = ""
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
            let fm = FileManager.default
            if fm.fileExists(atPath: databasePath) { return }

            let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName)
            try? fm.copyItem(atPath: databasePathFromApp!, toPath: databasePath)
        }

        func readDataFromDatabase() {
            orders.removeAll()
            var db: OpaquePointer?

            if sqlite3_open(databasePath, &db) == SQLITE_OK {
                let queryStatementString = "SELECT * FROM orders"
                var queryStatement: OpaquePointer?

                if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                    while sqlite3_step(queryStatement) == SQLITE_ROW {
                        let id = Int(sqlite3_column_int(queryStatement, 0))
                        let date = String(cString: sqlite3_column_text(queryStatement, 1))
                        let address = String(cString: sqlite3_column_text(queryStatement, 2))
                        let size = Int(sqlite3_column_int(queryStatement, 3))
                        let meatToppings = String(cString: sqlite3_column_text(queryStatement, 4))
                        let vegToppings = String(cString: sqlite3_column_text(queryStatement, 5))
                        

                        let order = OrderData()
                        order.initWithData(id: id, date: date, address: address, size: size, meatToppings: meatToppings, vegToppings: vegToppings)
                        
                        orders.append(order)
                    }
                    sqlite3_finalize(queryStatement)
                }
                sqlite3_close(db)
            }
        }

        func insertIntoDatabase(order: OrderData) -> Bool {
            var db: OpaquePointer?
            var returnCode = true

            if sqlite3_open(databasePath, &db) == SQLITE_OK {
                let insertStatementString = "INSERT INTO orders VALUES (NULL, ?, ?, ?, ?, ?)"
                var insertStatement: OpaquePointer?

                if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                    sqlite3_bind_text(insertStatement, 1, order.deliveryDate, -1, nil)
                    sqlite3_bind_text(insertStatement, 2, order.address, -1, nil)
                    sqlite3_bind_int(insertStatement, 3, Int32(order.size!))
                    sqlite3_bind_text(insertStatement, 4, order.meatToppings, -1, nil)
                    sqlite3_bind_text(insertStatement, 5, order.vegToppings, -1, nil)

                    if sqlite3_step(insertStatement) != SQLITE_DONE {
                        returnCode = false
                    }
                    sqlite3_finalize(insertStatement)
                }
                sqlite3_close(db)
            }
            return returnCode
        }
    
    



    //func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
     //   return true
    //}

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

