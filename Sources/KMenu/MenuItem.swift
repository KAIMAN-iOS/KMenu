//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit

public protocol Menuable {
    var title: String { get  }
    var image: UIImage? { get  }
    var completion: (() -> Void) { get }
}

public struct MenuItem {
    let title: String
    let image: UIImage?
    let completion: (() -> Void)
    
    public init(_ item: Menuable) {
        self.title = item.title
        self.image = item.image
        self.completion = item.completion
    }
}

/// ATA specific menu items
public enum AtaMenuItem {
    case user(selectionCompletion: (() -> Void))
    case disconnect(selectionCompletion: (() -> Void))
    case rideHistory(selectionCompletion: (() -> Void))
    case terms(selectionCompletion: (() -> Void))
    case contact(selectionCompletion: (() -> Void))
    case vehicle(selectionCompletion: (() -> Void))
    case licence(selectionCompletion: (() -> Void))
    case favourites(selectionCompletion: (() -> Void))
    case alert(selectionCompletion: (() -> Void))
    case group(selectionCompletion: (() -> Void))
    case expenseReport(selectionCompletion: (() -> Void))
    case bluetooth(selectionCompletion: (() -> Void))
}

extension AtaMenuItem: Menuable {
    public var title: String {
        switch self {
        case .user:             return NSLocalizedString("user", bundle: Bundle.module, comment: "user")
        case .disconnect:       return NSLocalizedString("disconnect", bundle: Bundle.module, comment: "disconnect")
        case .rideHistory:      return NSLocalizedString("rideHistory", bundle: Bundle.module, comment: "rideHistory")
        case .terms:            return NSLocalizedString("terms", bundle: Bundle.module, comment: "terms")
        case .contact:          return NSLocalizedString("contact", bundle: Bundle.module, comment: "contact")
        case .vehicle:          return NSLocalizedString("vehicle", bundle: Bundle.module, comment: "vehicle")
        case .licence:          return NSLocalizedString("licence", bundle: Bundle.module, comment: "licence")
        case .favourites:       return NSLocalizedString("favourites", bundle: Bundle.module, comment: "favourites")
        case .alert:            return NSLocalizedString("alert", bundle: Bundle.module, comment: "alert")
        case .group:            return NSLocalizedString("group", bundle: Bundle.module, comment: "group")
        case .expenseReport:    return NSLocalizedString("expenseReport", bundle: Bundle.module, comment: "expenseReport")
        case .bluetooth:        return NSLocalizedString("bluetooth", bundle: Bundle.module, comment: "bluetooth")
        }
    }
    
    public var image: UIImage? {
        switch self {
        case .user:             return nil
        case .disconnect:       return nil
        case .rideHistory:      return UIImage(named: "history")
        case .terms:            return UIImage(named: "terms")
        case .contact:          return UIImage(named: "contact")
        case .vehicle:          return UIImage(named: "car")
        case .licence:          return UIImage(named: "licence")
        case .favourites:       return UIImage(named: "favourites")
        case .alert:            return UIImage(named: "notification")
        case .group:            return UIImage(named: "group")
        case .expenseReport:    return UIImage(named: "expenseReport")
        case .bluetooth:       return UIImage(named: "bluetooth")
        }
    }
    
    public var completion: (() -> Void) {
        switch self {
        case .user(let selectionCompletion):            return selectionCompletion
        case .disconnect(let selectionCompletion):      return selectionCompletion
        case .rideHistory(let selectionCompletion):     return selectionCompletion
        case .terms(let selectionCompletion):           return selectionCompletion
        case .contact(let selectionCompletion):         return selectionCompletion
        case .vehicle(let selectionCompletion):         return selectionCompletion
        case .licence(let selectionCompletion):         return selectionCompletion
        case .favourites(let selectionCompletion):      return selectionCompletion
        case .alert(let selectionCompletion):           return selectionCompletion
        case .group(let selectionCompletion):           return selectionCompletion
        case .expenseReport(let selectionCompletion):   return selectionCompletion
        case .bluetooth(let selectionCompletion):       return selectionCompletion
        }
    }
    
    
}
