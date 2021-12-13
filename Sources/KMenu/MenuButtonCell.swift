//
//  File.swift
//  
//
//  Created by GG on 25/11/2020.
//

import UIKit
import FontExtension
import Ampersand
import NSAttributedStringBuilder

class MenuButtonCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!  {
        didSet {
            button.titleLabel?.font = .applicationFont(forTextStyle: .headline)
            button.setTitleColor(MenuViewController.configuration.palette.textOnPrimary, for: .normal)
            button.layer.cornerRadius = 10.0
            button.titleLabel?.minimumScaleFactor = 0.5
            button.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }

    @IBOutlet weak var additionnalInformation: UILabel!
    var item: MenuItem!  {
        didSet {
            configure()
        }
    }
    var numberOfAvailableDrivers: Int = 0
    var alertGroupCreated: Bool = false

    func configure(_ item: MenuItem) {
        self.item = item
    }
    
    func updateSOSButton(alertGroupCreated: Bool, numberOfAvailableDrivers: Int) {
        self.alertGroupCreated = alertGroupCreated
        self.numberOfAvailableDrivers = numberOfAvailableDrivers
    }
    
    private func configure() {
        guard alertGroupCreated else {
            button.setTitle(item.title.uppercased(), for: .normal)
            button.backgroundColor = MenuViewController.configuration.palette.inactive
            additionnalInformation.text = ""
            return
        }
        additionnalInformation.text = ""
        button.backgroundColor = MenuViewController.configuration.palette.primary
        // button
        let titles = item.title.split(separator: "#")
        guard titles.count == 2 else {
            button.setTitle(item.title, for: .normal)
            return
        }
        let sos = String(titles[0])
        let members = String(titles[1])
        button.titleLabel?.numberOfLines = 2
        button.setAttributedTitle(NSAttributedString {
            AText(sos)
                .font(.applicationFont(forTextStyle: .title3))
                .foregroundColor(MenuViewController.configuration.palette.textOnPrimary)
            
            LineBreak()
                .font(.applicationFont(ofSize: 0))
            
            AText(members)
                .font(.applicationFont(forTextStyle: .subheadline))
                .foregroundColor(MenuViewController.configuration.palette.textOnPrimary)
        }, for: .normal)
    }
}
