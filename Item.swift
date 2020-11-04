//
//  Item.swift
//  Project 3-ToDo
//
//  Created by Gracias Claude on 10/9/20.
//

import UIKit

class Item  : Equatable {
    var id:Int;
    var name:String;
    var description:String;
    let dateCreated: Date;
    var priority : String
    
    static func ==(lhs: Item, rhs: Item) -> Bool {
            return lhs.name == rhs.name
                && lhs.description == rhs.description
                && lhs.dateCreated == rhs.dateCreated
                && lhs.priority == rhs.priority
        }
    
    init(id: Int, name: String, description: String, priority:String) {
        self.name = name;
        self.description = description;
        self.dateCreated = Date();
        self.priority = priority;
        self.id = id
    }
    
   
    
}
