//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit
import KCoordinatorKit
import SideMenu
import ATAConfiguration
import Combine

public protocol UserDataDisplayable {
    var username: String { get }
    var rating: Double { get }
    var picture: CurrentValueSubject<UIImage?, Never> { get }
    var completion: (() -> Void) { get }
    var image: UIImage? { get }
}

public struct ATAMenuCoordinator {
    public enum Mode {
        case driver, passenger
    }
}

public protocol MenuDisplayable {
    func didShowMenu()
    func didHideMenu()
}

extension MenuDisplayable {
    func didShowMenu() {}
    func didHideMenu() {}
}

public class MenuCoordinator<DeepLink>: Coordinator<DeepLink> {
    public var userPublisher: PassthroughSubject<UserDataDisplayable, Never> = PassthroughSubject<UserDataDisplayable, Never>()
    public var menuImage: UIImage?  {
        didSet {
            guard let image = menuImage else { return }
            menuController.bottomImage.image = image
        }
    }
    var menuController: MenuViewController!
    public init(router: RouterType,
                rootViewController: UIViewController,
                items: [MenuItem],
                user: UserDataDisplayable,
                bottomImage: UIImage? = nil,
                mode: ATAMenuCoordinator.Mode = .driver,
                displayDelegate: MenuDisplayable? = nil,
                conf: ATAConfiguration) {
        super.init(router: router)
        menuController = MenuViewController.create(with: items, user: user, bottomImage: bottomImage, mode: mode, conf: conf)
        menuController.displayDelegate = displayDelegate
        makeRx()
        SideMenuManager.default.leftMenuNavigationController = SideMenuNavigationController(rootViewController: menuController)
        SideMenuManager.default.leftMenuNavigationController?.settings = makeSettings()
        SideMenuManager.default.addPanGestureToPresent(toView: router.navigationController.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: rootViewController.view)
    }
    
    private var subscriptions = Set<AnyCancellable>()
    private func makeRx() {
        userPublisher
            .sink { [weak self] user in
                self?.menuController.update(user)
            }
            .store(in: &subscriptions)
    }
    
    private func makeSettings() -> SideMenuSettings {
        let presentationStyle = SideMenuPresentationStyle.menuSlideIn
        presentationStyle.backgroundColor = #colorLiteral(red: 1, green: 0.192286253, blue: 0.2298730612, alpha: 1)
        presentationStyle.onTopShadowOpacity = 1
        presentationStyle.presentingScaleFactor = 1.0
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = UIScreen.main.bounds.width * 0.9
        settings.blurEffectStyle = .none
        settings.enableTapToDismissGesture = true
        settings.usingSpringWithDamping = 0.9
        return settings
    }
    
    public func updateSOSButton(alertGroupCreated: Bool, numberOfAvailableDrivers: Int) {
        menuController.updateSOSButton(alertGroupCreated: alertGroupCreated, numberOfAvailableDrivers: numberOfAvailableDrivers)
    }
    
    public func updateBadge(_ count: Int, for item: MenuItem) {
        menuController.updateBadge(count, for: item)
    }
}

extension String {
    func bundleLocale() -> String {
        NSLocalizedString(self, bundle: .module, comment: self)
    }
}



