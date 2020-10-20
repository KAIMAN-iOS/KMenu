//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit
import KCoordinatorKit
import SideMenu

class MenuCoordinator<DeepLink>: Coordinator<DeepLink> {
    
    init(router: RouterType, rootViewController: UIViewController, items: [MenuItem]) {
        super.init(router: router)
    }
}
