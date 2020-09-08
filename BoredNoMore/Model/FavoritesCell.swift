//
//  FavoritesCell.swift
//  Bored-No-More
//
//  Created by User on 8/10/20.
//

import UIKit

class FavoritesCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = UIColor(named: K.blueColor)
        textLabel?.font = UIFont(name: "Futura", size: 18)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
