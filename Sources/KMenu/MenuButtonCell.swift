//
//  File.swift
//  
//
//  Created by GG on 25/11/2020.
//

import UIKit
import FontExtension

class MenuButtonCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    
    func configure(_ item: MenuItem) {
        button.titleLabel?.font = FontType.custom(.title1, traits: nil).font
        button.setTitleColor(MenuViewController.configuration.palette.textOnPrimary, for: .normal)
        button.setTitle(item.title, for: .normal)
        button.layer.cornerRadius = 5.0
    }
}
