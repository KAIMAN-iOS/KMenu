//
//  ViewController.swift
//  iosExample
//
//  Created by GG on 20/10/2020.
//

import UIKit
import KCoordinatorKit
import KMenu
import ATAConfiguration

class Configuration: ATAConfiguration {
    var logo: UIImage? { nil }
    var palette: Palettable { Palette() }
}

class Palette: Palettable {
    var primary: UIColor { #colorLiteral(red: 0.8604696393, green: 0, blue: 0.1966537535, alpha: 1) }
    var secondary: UIColor { #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) }
    
    var mainTexts: UIColor { #colorLiteral(red: 0.1879811585, green: 0.1879865527, blue: 0.1879836619, alpha: 1) }
    
    var secondaryTexts: UIColor { #colorLiteral(red: 0.1565656662, green: 0.1736218631, blue: 0.2080874145, alpha: 1) }
    
    var textOnPrimary: UIColor { #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
    
    var inactive: UIColor { #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) }
    
    var placeholder: UIColor { #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) }
    var lightGray: UIColor { #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) }
    
    
}
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    struct User: UserDataDisplayable {
        var username: String = "John Doe"
        var licence: String? = "8769976780870"
        var picture: UIImage? = nil
        var completion: (() -> Void) = {
            print("user ^_^")
        }
    }

    var child: UIViewController!
    @IBAction func show(_ sender: Any) {
        let root = RootViewController.create()
        let router = Router(navigationController: UINavigationController(rootViewController: root))
        let items: [MenuItem] = [
            MenuItem(AtaMenuItem.vehicle(selectionCompletion: {
                print("vehicle")
            })),
            MenuItem(AtaMenuItem.group(selectionCompletion: {
                print("group")
            })),
            MenuItem(AtaMenuItem.myBookings(selectionCompletion: {
                print("group")
            })),
            MenuItem(AtaMenuItem.messages(selectionCompletion: {
                print("group")
            })),
            MenuItem(AtaMenuItem.contact(selectionCompletion: {
                print("alert")
            })),
            MenuItem(AtaMenuItem.legalNotice(appVersion: "6.6.6.", selectionCompletion: {
                print("alert")
            })),
            MenuItem(AtaMenuItem.alert(selectionCompletion: {
                print("alert")
            }))
        ]
        let coord = MenuCoordinator<Int>(router: router, rootViewController: root, items: items, user: User(), conf: Configuration())
        let controller = coord.toPresentable()
        child = controller
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
}

