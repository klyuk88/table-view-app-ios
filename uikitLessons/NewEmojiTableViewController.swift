//
//  NewEmojiTableViewController.swift
//  TableViewApp
//
//  Created by Илья Клюковский on 09.04.2023.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {

    @IBOutlet var emojiTextField: UITextField!
    
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet var nameTextField: UITextField!
    
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        print(sender.text!)
    }
    
    

}
