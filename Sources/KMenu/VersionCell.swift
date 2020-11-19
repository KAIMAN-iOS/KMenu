//
//  File.swift
//  
//
//  Created by GG on 18/11/2020.
//

import UIKit
import FontExtension
import LabelExtension

class VersionCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func configure(_ version: String) {
        label.set(text: version, for: FontType.custom(.caption2, traits: nil), textColor: MenuViewController.configuration.palette.mainTexts)
    }
}
