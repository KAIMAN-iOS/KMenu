//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit
import SideMenu
import FontExtension
import LabelExtension
import ATAConfiguration

class ItemButton: UIButton {
    var item: MenuItem
    
    init(item: MenuItem) {
        self.item = item
        super.init(frame: .zero)
        titleLabel?.font = FontType.custom(.title2, traits: nil).font
        contentHorizontalAlignment = .left
        setTitleColor(MenuViewController.configuration.palette.textOnPrimary, for: .normal)
        setTitle(item.title, for: .normal)
    }
    
    func update() {
//        titleLabel?.set(text: item.title, for: FontType.custom(.title2, traits: nil), textColor: MenuViewController.configuration.palette.textOnPrimary)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension UINavigationController {
    open override var prefersStatusBarHidden: Bool {
        return presentedViewController?.prefersStatusBarHidden ?? (topViewController?.prefersStatusBarHidden ?? true)
    }
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return presentedViewController?.preferredStatusBarUpdateAnimation ?? (topViewController?.preferredStatusBarUpdateAnimation ?? .fade)
    }
}
    
class MenuViewController: UIViewController {
    static var configuration: ATAConfiguration!
    static func create(with items: [MenuItem],
                       user: UserDataDisplayable?,
                       conf: ATAConfiguration) -> MenuViewController {
        let ctrl: MenuViewController = UIStoryboard(name: "Menu", bundle: Bundle.module).instantiateViewController(identifier: "MenuViewController")
        ctrl.items = items
        ctrl.user = user
        MenuViewController.configuration = conf
        return ctrl
    }
    var user: UserDataDisplayable?
    var items: [MenuItem] = []  {
        didSet {
            viewModel = MenuViewModel(items: items.filter({ $0.displayType != .important }))
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
    @IBOutlet weak var userStackView: UIStackView!
    
    var statusFrameHidden: Bool = true
    override var prefersStatusBarHidden: Bool { statusFrameHidden }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .slide }
    
    lazy var dataSource = viewModel.dataSource(for: tableView)
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        SideMenuManager.default.leftMenuNavigationController?.sideMenuDelegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        loadImportantItems()
        tableView.dataSource = dataSource
        viewModel.applySnapshot(in: dataSource)
        handleUserData()
        tableView.tableFooterView = UIView()
        view.backgroundColor = MenuViewController.configuration.palette.mainTexts
    }
    
    func loadImportantItems() {
        items.filter({ $0.displayType == .important }).forEach { item in
            let button = ItemButton(item: item)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            button.addTarget(self, action: #selector(handleTapOn(_:)), for: .touchUpInside)
            userStackView.addArrangedSubview(button)
            userStackView.setCustomSpacing(5, after: button)
            button.update()
        }
    }
    
    @objc func handleTapOn(_ button: ItemButton) {
        button.item.completion()
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
        icon.backgroundColor = MenuViewController.configuration.palette.inactive
        icon.image = user.picture ?? UIImage(named: "taxiDriver", in: .module, with: nil)
        name.set(text: user.username, for: FontType.custom(.title1, traits: nil), textColor: .white)
    }
    
    @IBAction func showUser() {
        user?.completion()
    }
}

extension MenuViewController: SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        statusFrameHidden = true
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        statusFrameHidden = false
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.items[indexPath.row].completion()
    }
}
