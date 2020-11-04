//
//  AddViewController.swift
//  Project 3-ToDo
//
//  Created by Gracias Claude on 10/9/20.
//

import UIKit
import SQLite3
class AddViewController : UIViewController {
    weak var itemViewController: ItemsViewController?
    
    
   
    var item: Item!;
    var itemStore: ItemStore!;
    var row: Int = 0;
    
    
    var db: OpaquePointer?
    var stmt: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
             .appendingPathComponent("items3.sqlite")
        
        print(fileURL.path)

    if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
                print("error opening database")
            }

    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Items (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, priority TEXT)", nil, nil, nil) != SQLITE_OK {
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("error creating table: \(errmsg)")
           }


    }
    
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var priorityField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    
    @IBAction func submitItem(_ sender: UIButton) {

         let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let queryString = "INSERT INTO Items (name, description, priority) VALUES (?,?,?)"

        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("error preparing insert: \(errmsg)")
                   return
               }

        if sqlite3_bind_text(stmt, 1, itemNameField.text, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("failure binding name: \(errmsg)")
                   return
               }

        if sqlite3_bind_text(stmt, 2, descriptionField.text, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("failure binding name: \(errmsg)")
                   return
               }
        
        if sqlite3_bind_text(stmt, 3, priorityField.text, -1, SQLITE_TRANSIENT) != SQLITE_OK{
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("failure binding name: \(errmsg)")
                   return
               }
        if sqlite3_step(stmt) != SQLITE_DONE {
                   let errmsg = String(cString: sqlite3_errmsg(db)!)
                   print("failure inserting hero: \(errmsg)")
                   return
               }
        print("Items saved successfully")
        
        //how to update the new to the row
        item.name = itemNameField.text ?? "Default Text"
        item.description = descriptionField.text ?? "Default Description"
        item.priority = priorityField.text ?? "Default pirority"
   
    
    }
    
    // USED FOR TESTING
    func readValues(){

        var itemList = [ItemTest]()
           //first empty the list of items
           itemList.removeAll()

           //this is our select query
           let queryString = "SELECT * FROM Items"

           //statement pointer
           var stmt:OpaquePointer?

           //preparing the query
           if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
               let errmsg = String(cString: sqlite3_errmsg(db)!)
               print("error preparing insert: \(errmsg)")
               return
           }


           //traversing through all the records
           while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let description = String(cString: sqlite3_column_text(stmt, 2))
            let priority = String(cString: sqlite3_column_text(stmt, 3))

//               adding values to list
            itemList.append(ItemTest(id: Int(id),  name: name, description: description, priority: priority))
            
           }
      
    
       }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "added":
        
    let itemsViewController = segue.destination as! ItemsViewController
        itemsViewController.itemStore = itemStore
//        itemsViewController.fileUrl = self.fileURL
    


    default:
    preconditionFailure("Unexpected segue identifier.")
    }
    }
}
