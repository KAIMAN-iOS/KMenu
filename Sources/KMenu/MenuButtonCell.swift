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
    var numberOfAvailableDrivers: Int = 0  {
        didSet {
            configure()
        }
    }

    func configure(_ item: MenuItem) {
        self.item = item
    }
    
    func updateSOSButton(numberOfAvailableDrivers: Int) {
        self.numberOfAvailableDrivers = numberOfAvailableDrivers
    }
    
    private func configure() {
        guard numberOfAvailableDrivers > 0 else {
            button.setTitle(item.title.uppercased(), for: .normal)
            button.backgroundColor = MenuViewController.configuration.palette.inactive
            additionnalInformation.text = ""
            return
        }
        // button
        button.setTitle(item.title, for: .normal)
        button.backgroundColor = MenuViewController.configuration.palette.primary
        // additionnal
        let formatString : String = NSLocalizedString("NumberOfDrivers", bundle: .module, comment: "NumberOfDrivers")
        let resultString : String = String.localizedStringWithFormat(formatString, numberOfAvailableDrivers)
        additionnalInformation.set(text: resultString, for: .caption1, textColor: MenuViewController.configuration.palette.inactive)
    }
}
