//
//  ViewController.swift
//  iosExample
//
//  Created by GG on 20/10/2020.
//

import UIKit
import KCoordinatorKit
import KMenu

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
        let coord = MenuCoordinator<Int>(router: router, rootViewController: root, items: items, user: User(), appVersion: "version 23.980.0990889089")
        let controller = coord.toPresentable()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
}

