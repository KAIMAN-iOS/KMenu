//
//  File.swift
//  
//
//  Created by GG on 18/11/2020.
//

import UIKit
import FontExtension
import LabelExtension
import ColorExtension

class VersionCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        print("Hightlighted")
        label.set(text: label.text, for: .caption2, textColor: highlighted ? MenuViewController.configuration.palette.mainTexts.lighter(by: 50) : MenuViewController.configuration.palette.mainTexts)
    }
    
    func configure(_ version: String) {
        label.set(text: version, for: .caption2, textColor: MenuViewController.configuration.palette.mainTexts)
        contentView.backgroundColor = MenuViewController.configuration.palette.background
    }
}
