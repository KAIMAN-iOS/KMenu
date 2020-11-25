//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit

public enum MenuDisplayType {
    case `default`, important, notice, button
}

public protocol Menuable {
    var title: String { get  }
    var completion: (() -> Void) { get }
    var displayType: MenuDisplayType { get }
}

public struct MenuItem: Hashable, Equatable {
    public static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let title: String
    let completion: (() -> Void)
    var displayType: MenuDisplayType
    
    public init(_ item: Menuable) {
        self.title = item.title
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
    case rideHistory(selectionCompletion: (() -> Void))
    case myBookings(selectionCompletion: (() -> Void))
    case terms(selectionCompletion: (() -> Void))
    case contact(selectionCompletion: (() -> Void))
    case vehicle(selectionCompletion: (() -> Void))
    case favourites(selectionCompletion: (() -> Void))
    case alert(selectionCompletion: (() -> Void))
    case group(selectionCompletion: (() -> Void))
    case parameters(selectionCompletion: (() -> Void))
    case messages(selectionCompletion: (() -> Void))
    case rideFlows(selectionCompletion: (() -> Void))
    case legalNotice(appVersion: String, selectionCompletion: (() -> Void))
}

extension AtaMenuItem: Menuable {
    public var title: String {
        switch self {
        case .user:                         return NSLocalizedString("user", bundle: Bundle.module, comment: "user")
        case .parameters:                   return NSLocalizedString("parameters", bundle: Bundle.module, comment: "parameters")
        case .messages:                     return NSLocalizedString("messages", bundle: Bundle.module, comment: "messages")
        case .rideHistory:                  return NSLocalizedString("rideHistory", bundle: Bundle.module, comment: "rideHistory")
        case .myBookings:                   return NSLocalizedString("myBookings", bundle: Bundle.module, comment: "myBookings")
        case .terms:                        return NSLocalizedString("terms", bundle: Bundle.module, comment: "terms")
        case .contact:                      return NSLocalizedString("contact", bundle: Bundle.module, comment: "contact")
        case .vehicle:                      return NSLocalizedString("vehicle", bundle: Bundle.module, comment: "vehicle")
        case .favourites:                   return NSLocalizedString("favourites", bundle: Bundle.module, comment: "favourites")
        case .alert:                        return NSLocalizedString("alert", bundle: Bundle.module, comment: "alert")
        case .group:                        return NSLocalizedString("group", bundle: Bundle.module, comment: "group")
        case .rideFlows:                    return NSLocalizedString("rideFlows", bundle: Bundle.module, comment: "rideFlows")
        case .legalNotice(let version, _):  return  NSLocalizedString("Legal notice", bundle: Bundle.module, comment: "Legal notice") + " - " + version
        }
    }
    
    public var completion: (() -> Void) {
        switch self {
        case .user(let selectionCompletion):            return selectionCompletion
        case .myBookings(let selectionCompletion):      return selectionCompletion
        case .parameters(let selectionCompletion):      return selectionCompletion
        case .rideHistory(let selectionCompletion):     return selectionCompletion
        case .terms(let selectionCompletion):           return selectionCompletion
        case .contact(let selectionCompletion):         return selectionCompletion
        case .vehicle(let selectionCompletion):         return selectionCompletion
        case .messages(let selectionCompletion):        return selectionCompletion
        case .favourites(let selectionCompletion):      return selectionCompletion
        case .alert(let selectionCompletion):           return selectionCompletion
        case .group(let selectionCompletion):           return selectionCompletion
        case .legalNotice(_, let selectionCompletion):  return selectionCompletion
        case .rideFlows(let selectionCompletion):       return selectionCompletion
        }
    }
    
    public var displayType: MenuDisplayType {
        switch self {
        case .legalNotice, .contact: return .notice
        case .messages, .myBookings: return .important
        case .alert: return .button
        default: return .default
        }
    }    
}
