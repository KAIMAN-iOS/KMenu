//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController {
    static func create(with items: [MenuItem]) -> MenuViewController {
        let ctrl: MenuViewController = UIStoryboard(name: "Menu", bundle: Bundle.module).instantiateViewController(identifier: "MenuViewController")
        ctrl.items = items
        return ctrl
    }
    var items: [MenuItem] = []  {
        didSet {
            viewModel = MenuViewModel(items: items)
        }
    }
    var viewModel: MenuViewModel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var licence: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
