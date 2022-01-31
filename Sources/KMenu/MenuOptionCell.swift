//
//  File.swift
//  
//
//  Created by Jérôme on 31/01/2022.
//

import UIKit
import FontExtension
import Ampersand
import NSAttributedStringBuilder

class MenuOptionCell: UITableViewCell {
    @IBOutlet weak var card: UIView! {
        didSet {
            card.backgroundColor = MenuViewController.configuration.palette.lightGray
            card.cornerRadius = 10
            card.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    func configure() {
        titleLabel.set(text: "option title".bundleLocale(), for: .caption2, textColor: MenuViewController.configuration.palette.mainTexts)
        subtitleLabel.set(text: "option subtitle".bundleLocale(), for: .caption2, textColor: MenuViewController.configuration.palette.mainTexts)
    }
}
