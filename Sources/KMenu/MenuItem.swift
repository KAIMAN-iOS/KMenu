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
    var id: String { get }
    var title: String { get  }
    var completion: (() -> Void) { get }
    var displayType: MenuDisplayType { get }
}

public struct MenuItem: Hashable, Equatable {
    public static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let id: String
    let title: String
    let completion: (() -> Void)
    var displayType: MenuDisplayType
    
    public init(_ item: Menuable) {
        self.id = item.id
        self.title = item.title
        self.completion = item.completion
        self.displayType = item.displayType
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
    case alert(alertGroupCreated: Bool, numberOfAvailableDrivers: Int, selectionCompletion: (() -> Void))
    case group(selectionCompletion: (() -> Void))
    case parameters(selectionCompletion: (() -> Void))
    case messages(selectionCompletion: (() -> Void))
    case rideFlows(selectionCompletion: (() -> Void))
    case expenseReport(selectionCompletion: (() -> Void))
    case shareRide(selectionCompletion: (() -> Void))
    case legalNotice(appVersion: String, selectionCompletion: (() -> Void))
}

extension AtaMenuItem: Menuable {
    public var id: String {
        switch self {
        case .user: return "user"
        case .rideHistory: return "rideHistory"
        case .myBookings: return "myBookings"
        case .terms: return "terms"
        case .contact: return "contact"
        case .vehicle: return "vehicle"
        case .favourites: return "favourites"
        case .alert: return "alert"
        case .group: return "group"
        case .parameters: return "parameters"
        case .messages: return "messages"
        case .rideFlows: return "rideFlows"
        case .expenseReport: return "expenseReport"
        case .shareRide: return "shareRide"
        case .legalNotice: return "legalNotice"
        }
    }
    
    public var title: String {
        switch self {
        case .user:                         return NSLocalizedString("user", bundle: .module, comment: "user")
        case .parameters:                   return NSLocalizedString("parameters", bundle: .module, comment: "parameters")
        case .messages:                     return NSLocalizedString("messages", bundle: .module, comment: "messages")
        case .rideHistory:                  return NSLocalizedString("rideHistory", bundle: .module, comment: "rideHistory")
        case .myBookings:                   return NSLocalizedString("myBookings", bundle: .module, comment: "myBookings")
        case .terms:                        return NSLocalizedString("terms", bundle: .module, comment: "terms")
        case .contact:                      return NSLocalizedString("contact", bundle: .module, comment: "contact")
        case .vehicle:                      return NSLocalizedString("vehicle", bundle: .module, comment: "vehicle")
        case .favourites:                   return NSLocalizedString("favourites", bundle: .module, comment: "favourites")
        case .group:                        return NSLocalizedString("group", bundle: .module, comment: "group")
        case .rideFlows:                    return NSLocalizedString("rideFlows", bundle: .module, comment: "rideFlows")
        case .expenseReport:                return NSLocalizedString("expenseReport", bundle: .module, comment: "rideFlows")
        case .shareRide:                    return NSLocalizedString("shareRide", bundle: .module, comment: "shareRide")
        case .legalNotice(let version, _):  return NSLocalizedString("Legal notice", bundle: .module, comment: "Legal notice") + " - " + version
        case .alert(let created, _, _):
            return NSLocalizedString(created ? "alert" : "alert > configure", bundle: .module, comment: "Legal notice")
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
        case .alert(_, _, let selectionCompletion):     return selectionCompletion
        case .group(let selectionCompletion):           return selectionCompletion
        case .legalNotice(_, let selectionCompletion):  return selectionCompletion
        case .rideFlows(let selectionCompletion):       return selectionCompletion
        case .shareRide(let selectionCompletion):       return selectionCompletion
        case .expenseReport(let selectionCompletion):   return selectionCompletion
        }
    }
    
    public var displayType: MenuDisplayType {
        switch self {
        case .legalNotice, .contact: return .notice
        case .messages, .rideHistory, .shareRide: return .important
        case .alert: return .button
        default: return .default
        }
    }    
}
