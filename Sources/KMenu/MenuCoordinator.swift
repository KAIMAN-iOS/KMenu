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

public protocol UserDataDisplayable {
    var username: String { get }
    var picture: UIImage? { get }
    var completion: (() -> Void) { get }
}

public struct ATAMenuCoordinator {
    public enum Mode {
        case driver, passenger
    }
}

public class MenuCoordinator<DeepLink>: Coordinator<DeepLink> {
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
                conf: ATAConfiguration) {
        super.init(router: router)
        menuController = MenuViewController.create(with: items, user: user, bottomImage: bottomImage, mode: mode, conf: conf)
        SideMenuManager.default.leftMenuNavigationController = SideMenuNavigationController(rootViewController: menuController)
        SideMenuManager.default.leftMenuNavigationController?.settings = makeSettings()
        SideMenuManager.default.addPanGestureToPresent(toView: router.navigationController.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: rootViewController.view)
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
}

extension String {
    func bundleLocale() -> String {
        NSLocalizedString(self, bundle: .module, comment: self)
    }
}



