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
        addDefaultSelectedBackground(MenuViewController.configuration.palette.primary.withAlphaComponent(0.5))
    }
    
    func configure(_ item: MenuItem) {
        icon.image = item.image
        icon.tintColor = MenuViewController.configuration.palette.inactive
        name.set(text: item.title, for: FontType.custom(.headline, traits: [.traitBold]), textColor: MenuViewController.configuration.palette.mainTexts)
    }
}
