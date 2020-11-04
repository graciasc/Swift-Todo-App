//
//  DetailViewController.swift
//  Project 3-ToDo
//
//  Created by Gracias Claude on 10/9/20.
//

import UIKit

class DetailsViewController : UIViewController {
    
    var item: Item!;
    
    
    @IBOutlet weak var itemField: UITextField!
    @IBOutlet weak var priorityField: UITextField!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        itemField.text = item.name
        priorityField.text = item.priority
        dateField.text = dateFormatter.string(from: item.dateCreated)
        descriptionField.text = item.description
    }
}
