//
//  NewEmojiTableViewController.swift
//  TableViewApp
//
//  Created by Илья Клюковский on 09.04.2023.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavorite: false)

    @IBOutlet var emojiTextField: UITextField!
    
    @IBOutlet var descriptionTextField: UITextField!
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveBtnState()
    }
    
    private func updateSaveBtnState() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descText.isEmpty
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        updateSaveBtnState()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {
            return
        }
        var emoji = emojiTextField.text ?? ""
        var name = nameTextField.text ?? ""
        var desc = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: desc, isFavorite: self.emoji.isFavorite)
        
        
    }
    
        

}
