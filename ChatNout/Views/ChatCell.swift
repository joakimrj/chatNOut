//
//  ChatCell.swift
//  ChatNout
//
//  Created by Joakim Jorde on 9/28/18.
//  Copyright © 2018 Joakim Jorde. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        bubbleView.layer.cornerRadius = 16
        bubbleView.clipsToBounds = true
        
    }

}
