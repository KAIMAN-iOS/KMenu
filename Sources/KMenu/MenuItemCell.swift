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
import ColorExtension

class MenuItemCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addDefaultSelectedBackground(MenuViewController.configuration.palette.mainTexts.withAlphaComponent(0.5))
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        print("Hightlighted")
        name.set(text: name.text, for: .title3, textColor: highlighted ? MenuViewController.configuration.palette.mainTexts.lighter(by: 50) : MenuViewController.configuration.palette.mainTexts)
    }
    
    func configure(_ item: MenuItem) {
        name.set(text: item.title, for: .title3, textColor: MenuViewController.configuration.palette.mainTexts)
    }
}
