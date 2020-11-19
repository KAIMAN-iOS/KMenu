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
    var primary: UIColor { #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) }
    var secondary: UIColor { #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) }
    
    var mainTexts: UIColor { #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) }
    
    var secondaryTexts: UIColor { #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1) }
    
    var textOnPrimary: UIColor { #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) }
    
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

    @IBAction func show(_ sender: Any) {
        let root = RootViewController.create()
        let router = Router(navigationController: UINavigationController(rootViewController: root))
        let items: [MenuItem] = [
            MenuItem(AtaMenuItem.vehicle(selectionCompletion: {
                print("vehicle")
            })),
            MenuItem(AtaMenuItem.alert(selectionCompletion: {
                print("User")
            })),
            MenuItem(AtaMenuItem.group(selectionCompletion: {
                print("User")
            })),
            MenuItem(AtaMenuItem.expenseReport(selectionCompletion: {
                print("User")
            })),
            MenuItem(AtaMenuItem.disconnect(selectionCompletion: {
                print("disconnect")
            })),
            MenuItem(AtaMenuItem.bluetooth(selectionCompletion: {
                print("disconnect")
            })),
            MenuItem(AtaMenuItem.rideFlows(selectionCompletion: {
                print("disconnect")
            })),
            MenuItem(AtaMenuItem.diagnosis(selectionCompletion: {
                print("disconnect")
            }))
        ]
        let coord = MenuCoordinator<Int>(router: router, rootViewController: root, items: items, user: User(), conf: Configuration())
        let controller = coord.toPresentable()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
}

