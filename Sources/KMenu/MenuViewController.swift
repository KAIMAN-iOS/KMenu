//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit
import SideMenu
import FontExtension

class MenuViewController: UIViewController {
    static func create(with items: [MenuItem], user: UserDataDisplayable?, appVersion: String) -> MenuViewController {
        let ctrl: MenuViewController = UIStoryboard(name: "Menu", bundle: Bundle.module).instantiateViewController(identifier: "MenuViewController")
        ctrl.items = items
        ctrl.user = user
        ctrl.appVersion = appVersion
        return ctrl
    }
    var appVersion: String = ""
    var user: UserDataDisplayable?
    var items: [MenuItem] = []  {
        didSet {
            viewModel = MenuViewModel(items: items)
        }
    }
    var viewModel: MenuViewModel!
    @IBOutlet weak var tableView: UITableView!  {
        didSet {
            tableView.delegate = self
            tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
        }
    }

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var licence: UILabel!
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var version: UILabel!
    
    lazy var dataSource = viewModel.dataSource(for: tableView)
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.dataSource = dataSource
        viewModel.applySnapshot(in: dataSource)
        handleUserData()
        tableView.tableFooterView = UIView()
    }
    
    func handleUserData() {
        guard let user = user else {
            userStackView.arrangedSubviews.forEach({ $0.isHidden = true })
            return
        }
        icon.layer.cornerRadius = icon.bounds.midX
        icon.layer.borderWidth = 2.0
        icon.layer.borderColor = UIColor.white.cgColor
        icon.clipsToBounds = true
        icon.backgroundColor = #colorLiteral(red: 0.6176490188, green: 0.6521512866, blue: 0.7114837766, alpha: 1)
        icon.image = user.picture ?? UIImage(named: "taxiDriver", in: .module, with: nil)
        name.set(text: user.username, for: FontType.title, textColor: .white)
        licence.set(text: user.licence, for: FontType.custom(.caption1, traits: nil), textColor: UIColor.white.withAlphaComponent(0.75))
        licence.isHidden = user.licence == nil
        version.text = appVersion
    }
    
    @IBAction func showUser() {
        user?.completion()
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.items[indexPath.row].completion()
    }
}
