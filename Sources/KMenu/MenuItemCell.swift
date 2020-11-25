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
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addDefaultSelectedBackground(MenuViewController.configuration.palette.mainTexts.withAlphaComponent(0.5))
    }
    
    func configure(_ item: MenuItem) {
        name.set(text: item.title, for: FontType.custom(.title2, traits: nil), textColor: MenuViewController.configuration.palette.mainTexts)
    }
}
