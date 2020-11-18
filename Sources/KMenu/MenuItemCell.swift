//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit
import TableViewExtension
import LabelExtension
import FontExtension

class MenuItemCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addDefaultSelectedBackground(#colorLiteral(red: 1, green: 0.192286253, blue: 0.2298730612, alpha: 1).withAlphaComponent(0.5))
    }
    
    func configure(_ item: MenuItem) {
        icon.image = item.image
        icon.tintColor = #colorLiteral(red: 0.6176490188, green: 0.6521512866, blue: 0.7114837766, alpha: 1)
        name.set(text: item.title, for: FontType.custom(.headline, traits: [.traitBold]), textColor: #colorLiteral(red: 0.1234303191, green: 0.1703599989, blue: 0.2791167498, alpha: 1))
    }
}
