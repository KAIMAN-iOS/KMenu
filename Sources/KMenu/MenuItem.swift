//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit

public enum MenuDisplayType {
    case `default`, notice
}

public protocol Menuable {
    var title: String { get  }
    var image: UIImage? { get  }
    var completion: (() -> Void) { get }
    var displayType: MenuDisplayType { get }
}

public struct MenuItem: Hashable, Equatable {
    public static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let title: String
    let image: UIImage?
    let completion: (() -> Void)
    var displayType: MenuDisplayType
    
    public init(_ item: Menuable) {
        self.title = item.title
        self.image = item.image
        self.completion = item.completion
        self.displayType = item.displayType
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
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
    case rideFlows(selectionCompletion: (() -> Void))
    case diagnosis(selectionCompletion: (() -> Void))
    case legalNotice(appVersion: String, selectionCompletion: (() -> Void))
}

extension AtaMenuItem: Menuable {
    public var title: String {
        switch self {
        case .user:                         return NSLocalizedString("user", bundle: Bundle.module, comment: "user")
        case .disconnect:                   return NSLocalizedString("disconnect", bundle: Bundle.module, comment: "disconnect")
        case .rideHistory:                  return NSLocalizedString("rideHistory", bundle: Bundle.module, comment: "rideHistory")
        case .terms:                        return NSLocalizedString("terms", bundle: Bundle.module, comment: "terms")
        case .contact:                      return NSLocalizedString("contact", bundle: Bundle.module, comment: "contact")
        case .vehicle:                      return NSLocalizedString("vehicle", bundle: Bundle.module, comment: "vehicle")
        case .licence:                      return NSLocalizedString("licence", bundle: Bundle.module, comment: "licence")
        case .favourites:                   return NSLocalizedString("favourites", bundle: Bundle.module, comment: "favourites")
        case .alert:                        return NSLocalizedString("alert", bundle: Bundle.module, comment: "alert")
        case .group:                        return NSLocalizedString("group", bundle: Bundle.module, comment: "group")
        case .expenseReport:                return NSLocalizedString("expenseReport", bundle: Bundle.module, comment: "expenseReport")
        case .bluetooth:                    return NSLocalizedString("bluetooth", bundle: Bundle.module, comment: "bluetooth")
        case .rideFlows:                    return NSLocalizedString("rideFlows", bundle: Bundle.module, comment: "expenseReport")
        case .diagnosis:                    return NSLocalizedString("diagnosis", bundle: Bundle.module, comment: "bluetooth")
        case .legalNotice(let version, _):  return  NSLocalizedString("Legal notice", bundle: Bundle.module, comment: "Legal notice") + " - " + version
        }
    }
    
    public var image: UIImage? {
        switch self {
        case .user:             return nil
        case .disconnect:       return UIImage(named: "disconnect", in: .module, compatibleWith: nil)
        case .rideHistory:      return UIImage(named: "history", in: .module, compatibleWith: nil)
        case .terms:            return UIImage(named: "terms", in: .module, compatibleWith: nil)
        case .contact:          return UIImage(named: "contact", in: .module, compatibleWith: nil)
        case .vehicle:          return UIImage(named: "car", in: .module, compatibleWith: nil)
        case .licence:          return UIImage(named: "licence", in: .module, compatibleWith: nil)
        case .favourites:       return UIImage(named: "favourites", in: .module, compatibleWith: nil)
        case .alert:            return UIImage(named: "notification", in: .module, compatibleWith: nil)
        case .group:            return UIImage(named: "group", in: .module, compatibleWith: nil)
        case .expenseReport:    return UIImage(named: "expenseReport", in: .module, compatibleWith: nil)
        case .bluetooth:        return UIImage(named: "bluetooth", in: .module, compatibleWith: nil)
        case .rideFlows:        return UIImage(named: "rideFlow", in: .module, compatibleWith: nil)
        case .diagnosis:        return UIImage(named: "diagnosis", in: .module, compatibleWith: nil)
        case .legalNotice:      return nil
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
        case .rideFlows(let selectionCompletion):       return selectionCompletion
        case .diagnosis(let selectionCompletion):       return selectionCompletion
        case .legalNotice(_, let selectionCompletion):  return selectionCompletion
        }
    }
    
    public var displayType: MenuDisplayType {
        switch self {
        case .legalNotice: return .notice
        default: return .default
        }
    }    
}
