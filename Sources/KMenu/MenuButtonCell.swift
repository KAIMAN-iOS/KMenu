//
//  File.swift
//  
//
//  Created by GG on 25/11/2020.
//

import UIKit
import FontExtension
import Ampersand

class MenuButtonCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!
    
    func configure(_ item: MenuItem) {
        button.titleLabel?.font = .applicationFont(forTextStyle: .title1)
        button.setTitleColor(MenuViewController.configuration.palette.textOnPrimary, for: .normal)
        button.setTitle(item.title, for: .normal)
        button.layer.cornerRadius = 5.0
    }
}
