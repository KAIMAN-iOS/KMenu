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
    case rideHistory(displayType: MenuDisplayType, selectionCompletion: (() -> Void))
    case myBookings(displayType: MenuDisplayType, selectionCompletion: (() -> Void))
    case terms(selectionCompletion: (() -> Void))
    case contact(displayType: MenuDisplayType, selectionCompletion: (() -> Void))
    case paymentMethod(selectionCompletion: (() -> Void))
    case vehicle(selectionCompletion: (() -> Void))
    case favourites(selectionCompletion: (() -> Void))
    case alert(alertGroupCreated: Bool, numberOfAvailableDrivers: Int, selectionCompletion: (() -> Void))
    case group(selectionCompletion: (() -> Void))
    case parameters(selectionCompletion: (() -> Void))
    case messages(displayType: MenuDisplayType, selectionCompletion: (() -> Void))
    case rideFlows(selectionCompletion: (() -> Void))
    case expenseReport(selectionCompletion: (() -> Void))
    case shareRide(selectionCompletion: (() -> Void))
    case marketPlace(selectionCompletion: (() -> Void))
    case legalNotice(appVersion: String, selectionCompletion: (() -> Void))
    case custom(title: String, displayType: MenuDisplayType, selectionCompletion: (() -> Void))
    case shareApp(selectionCompletion: (() -> Void))
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
        case .marketPlace: return "marketPlace"
        case .paymentMethod: return "paymentMethod"
        case .custom(let title, _, _): return title
        case .shareApp: return "shareApp"
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
        case .paymentMethod:                return NSLocalizedString("paymentMethod", bundle: .module, comment: "rideFlows")
        case .shareRide:                    return NSLocalizedString("shareRide", bundle: .module, comment: "shareRide")
        case .marketPlace:                  return NSLocalizedString("marketPlace", bundle: .module, comment: "shareRide")
        case .legalNotice(let version, _):  return NSLocalizedString("Legal notice", bundle: .module, comment: "Legal notice") + " - " + version
        case .alert(let created, let numberOfAvailableDrivers, _):
            guard created == true else {
                return NSLocalizedString("alert > configure", bundle: .module, comment: "alert > configure")
            }
            let formatString : String = NSLocalizedString("NumberOfDrivers", bundle: .module, comment: "NumberOfDrivers")
            let resultString : String = String.localizedStringWithFormat(formatString, numberOfAvailableDrivers)
            return String(format: "%@#%@",
                          NSLocalizedString("alert", bundle: .module, comment: "alert"),
                          resultString)
        case .custom(let title, _, _): return title
        case .shareApp: return NSLocalizedString("shareApp", bundle: .module, comment: "shareApp")
        }
    }
    
    public var completion: (() -> Void) {
        switch self {
        case .user(let selectionCompletion):            return selectionCompletion
        case .myBookings(_, let selectionCompletion):   return selectionCompletion
        case .parameters(let selectionCompletion):      return selectionCompletion
        case .rideHistory(_, let selectionCompletion):  return selectionCompletion
        case .terms(let selectionCompletion):           return selectionCompletion
        case .contact(_, let selectionCompletion):         return selectionCompletion
        case .vehicle(let selectionCompletion):         return selectionCompletion
        case .messages(_, let selectionCompletion):     return selectionCompletion
        case .favourites(let selectionCompletion):      return selectionCompletion
        case .alert(_, _, let selectionCompletion):     return selectionCompletion
        case .group(let selectionCompletion):           return selectionCompletion
        case .legalNotice(_, let selectionCompletion):  return selectionCompletion
        case .rideFlows(let selectionCompletion):       return selectionCompletion
        case .shareRide(let selectionCompletion):       return selectionCompletion
        case .expenseReport(let selectionCompletion):   return selectionCompletion
        case .paymentMethod(let selectionCompletion):   return selectionCompletion
        case .marketPlace(let selectionCompletion):     return selectionCompletion
        case .custom(_, _, let completion): return completion
        case .shareApp(let selectionCompletion): return selectionCompletion
        }
    }
    
    public var displayType: MenuDisplayType {
        switch self {
        case .parameters, .legalNotice, .shareApp: return .notice
        case .shareRide, .marketPlace: return .important
        case .messages(let displayType, _): return displayType
        case .contact(let displayType, _): return displayType
        case .rideHistory(let displayType, _): return displayType
        case .myBookings(let displayType, _): return displayType
        case .alert: return .button
        case .custom(_, let display, _): return display
        default: return .default
        }
    }    
}
