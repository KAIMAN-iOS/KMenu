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
import Cosmos
import Ampersand
import Combine
import ATAViews

class ImportantItem: UIStackView {
    var item: MenuItem!
    let button: ItemButton!
    let badge = Badge()
    init(item: MenuItem) {
        self.item = item
        button = ItemButton(item: item)
        super.init(frame: .zero)
        addArrangedSubview(button)
        addArrangedSubview(badge)
        axis = .horizontal
        distribution = .fill
        alignment = .center
        spacing = 8
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(_ count: Int) {
        badge.update(count)
    }
}

class ItemButton: UIButton {
    var item: MenuItem
    var badge: BadgeHub!
    
    init(item: MenuItem) {
        self.item = item
        super.init(frame: .zero)
        badge = ATABadgeView(view: self)
        titleLabel?.font = .applicationFont(forTextStyle: .title3)
        contentHorizontalAlignment = .left
        setTitleColor(MenuViewController.configuration.palette.textOnDark, for: .normal)
        setTitleColor(MenuViewController.configuration.palette.placeholder, for: .highlighted)
        setTitleColor(MenuViewController.configuration.palette.placeholder, for: .selected)
        setTitle(item.title, for: .normal)
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .horizontal)
    }
    
    func update(_ count: Int) {
        badge.setCount(count)
        layoutIfNeeded()
        badge.setCircleAtFrame(CGRect(origin: CGPoint(x: frame.width - 10, y: 0),
                                      size: CGSize(width: 23, height: 23)))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension UINavigationController {
    open override var childForStatusBarHidden: UIViewController? {
        presentedViewController ?? viewControllers.last
    }
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
                       bottomImage: UIImage? = nil,
                       mode: ATAMenuCoordinator.Mode = .driver,
                       conf: ATAConfiguration) -> MenuViewController {
        let ctrl: MenuViewController = UIStoryboard(name: "Menu", bundle: Bundle.module).instantiateViewController(identifier: "MenuViewController")
        ctrl.items = items
        ctrl.user = user
        ctrl.mode = mode
        if let image = bottomImage {
            ctrl._bottomImage = image
        }
        MenuViewController.configuration = conf
        ATABadgeView.circleBackgroundColor = conf.palette.primary
        ATABadgeView.textColor = conf.palette.textOnPrimary
        return ctrl
    }
    var mode: ATAMenuCoordinator.Mode!
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

    var _bottomImage: UIImage? = nil
    @IBOutlet weak var bottomImage: UIImageView!  {
        didSet {
            if let image = _bottomImage {
                bottomImage.image = image
            }
        }
    }

    @IBOutlet weak var editLabel: UILabel!  {
        didSet {
            editLabel.set(text: "edit profile".bundleLocale(), for: .caption2, textColor: MenuViewController.configuration.palette.textOnDark)
        }
    }

    @IBOutlet weak var icon: UIImageView!  {
        didSet {
            icon.image = UIImage(named: "passenger", in: .module, with: nil)!
            icon.roundedCorners = true
            icon.layer.borderWidth = 1.0
            icon.layer.borderColor = MenuViewController.configuration.palette.secondary.cgColor
            icon.clipsToBounds = true
            icon.backgroundColor = MenuViewController.configuration.palette.secondary
            icon.tintColor = MenuViewController.configuration.palette.lightGray
        }
    }

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userStackView: UIStackView!
    @IBOutlet weak var rating: CosmosView!  {
        didSet {
            var settings: CosmosSettings = rating.settings
            settings.fillMode = .precise
            rating.settings = settings
        }
    }

    var statusFrameHidden: Bool = true
    override var prefersStatusBarHidden: Bool { statusFrameHidden }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { .slide }
    private var subscriptions = Set<AnyCancellable>()
    
    lazy var dataSource = viewModel.dataSource(for: tableView)
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        view.backgroundColor = UIColor(named: "secondary")! // #colorLiteral(red: 0.09803921729, green: 0.09803921729, blue: 0.09803921729, alpha: 1)
        rating.isHidden = mode == .passenger
        editLabel.isHidden = mode != .passenger
        (editLabel.superview as? UIStackView)?.spacing = mode == .passenger ? -2 : userStackView.spacing
        SideMenuManager.default.leftMenuNavigationController?.sideMenuDelegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        loadImportantItems()
        tableView.dataSource = dataSource
        viewModel.applySnapshot(in: dataSource)
        handleUserData()
        tableView.tableFooterView = UIView()
    }
    
    func update(_ user: UserDataDisplayable) {
        self.user = user
        guard icon != nil else { return }
        name.set(text: user.username, for: .title2, textColor: .white)
        rating.rating = user.rating
        subscriptions.removeAll()
        user
            .picture
            .subscribe(on: DispatchQueue.global(qos: .background))
            .replaceEmpty(with: user.image ?? UIImage(named: "passenger", in: .module, with: nil))
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: icon)
            .store(in: &subscriptions)
    }
    
    func loadImportantItems() {
        items.filter({ $0.displayType == .important }).forEach { item in
            let button = ItemButton(item: item)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: -2, bottom: 10, right: 10)
            button.addTarget(self, action: #selector(handleTapOn(_:)), for: .touchUpInside)
            userStackView.addArrangedSubview(button)
            userStackView.setCustomSpacing(0, after: button)
        }
    }
    
    private var unreadCounts: [MenuItem: Int] = [:]
    func updateBadge(_ count: Int, for item: MenuItem) {
        unreadCounts[item] = count
        guard userStackView != nil else { return }
        userStackView
            .arrangedSubviews
            .compactMap({ $0 as? ItemButton })
            .filter({ $0.item == item })
            .first?.update(count)
    }
    
    @objc func handleTapOn(_ button: ItemButton) {
        button.item.completion()
    }
    
    func updateSOSButton(alertGroupCreated: Bool, numberOfAvailableDrivers: Int) {
        viewModel.updateSOSButton(alertGroupCreated: alertGroupCreated, numberOfAvailableDrivers: numberOfAvailableDrivers) 
    }
    
    func handleUserData() {
        guard let user = user else {
            userStackView.arrangedSubviews.forEach({ $0.isHidden = true })
            return
        }
        if user.picture.value != nil {
            user
                .picture
                .subscribe(on: DispatchQueue.global(qos: .background))
                .replaceEmpty(with: user.image ?? UIImage(named: "passenger", in: .module, with: nil))
                .receive(on: DispatchQueue.main)
                .assign(to: \.image, on: icon)
                .store(in: &subscriptions)
        }
        name.set(text: user.username, for: .title2, textColor: .white)
        rating.rating = user.rating
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
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        unreadCounts.forEach { [weak self] item, count in
            self?.updateBadge(count, for: item)
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
