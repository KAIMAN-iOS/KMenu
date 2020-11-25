//
//  RootViewController.swift
//  iosExample
//
//  Created by GG on 20/10/2020.
//

import UIKit
import SideMenu
import UIViewControllerExtension

class RootViewController: UIViewController {
    static func create() -> RootViewController {
        return RootViewController.loadFromStoryboard(identifier: "RootViewController", storyboardName: "Main")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showMenu))
        navigationItem.leftBarButtonItem = menu
        // Do any additional setup after loading the view.
    }
    
    @objc func showMenu() {
        guard let menu = SideMenuManager.default.leftMenuNavigationController else { return }
        present(menu, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
