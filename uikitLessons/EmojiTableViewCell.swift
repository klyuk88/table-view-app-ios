//
//  EmojiTableViewCell.swift
//  uikitLessons
//
//  Created by Илья Клюковский on 09.04.2023.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    
    
    @IBOutlet var emojiLabel: UILabel!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(object: Emoji) {
        self.emojiLabel.text =  object.emoji
        self.nameLabel.text =  object.name
        self.descriptionLabel.text =  object.description
    }
   

}
