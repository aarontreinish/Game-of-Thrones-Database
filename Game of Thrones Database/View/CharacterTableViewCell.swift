//
//  CharacterTableViewCell.swift
//  Game of Thrones Database
//
//  Created by Aaron Treinish on 12/11/18.
//  Copyright © 2018 Aaron Treinish. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var booksLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
