//
//  File.swift
//  
//
//  Created by GG on 20/10/2020.
//

import UIKit
import TableViewExtension

class MenuViewModel {
    var items: [MenuItem] = []
    init(items: [MenuItem]) {
        self.items = items
    }
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, MenuItem>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Section, MenuItem>
    var dataSource: DataSource!
    func applySnapshot(in dataSource: DataSource, animatingDifferences: Bool = true) {
        self.dataSource = dataSource
        var currentSnapShot = dataSource.snapshot()
        if currentSnapShot.itemIdentifiers.count == 0 {
            currentSnapShot.appendSections([.main])
            currentSnapShot.appendItems(items, toSection: .main)
        }
        dataSource.apply(currentSnapShot, animatingDifferences: animatingDifferences) {
            print("osiuvno")
        }
    }
    
    var numberOfAvailableDrivers: Int = 0
    var alertGroupCreated: Bool = false
    func updateSOSButton(alertGroupCreated: Bool, numberOfAvailableDrivers: Int) {
        
        guard let item = items.filter({ item -> Bool in
            item.id == AtaMenuItem.alert(alertGroupCreated: alertGroupCreated, numberOfAvailableDrivers: self.numberOfAvailableDrivers, selectionCompletion: {}).id
              }).first,
              let index = items.firstIndex(of: item) else {
            return
        }
        self.numberOfAvailableDrivers = numberOfAvailableDrivers
        self.alertGroupCreated = alertGroupCreated
        
        let alert = MenuItem(AtaMenuItem.alert(alertGroupCreated: alertGroupCreated, numberOfAvailableDrivers: numberOfAvailableDrivers, selectionCompletion: item.completion))
        items.removeAll(where: { $0 == item })
        items.insert(alert, at: index)
        
        guard let source = dataSource,
              var snap = dataSource?.snapshot() else { return }
        snap.deleteItems([item])
        snap.insertItems([alert], afterItem: snap.itemIdentifiers[index.advanced(by: -1)])
        source.apply(snap, animatingDifferences: false, completion: nil)
        return
    }
    
    func dataSource(for tableView: UITableView) -> DataSource {
        let datasource = DataSource(tableView: tableView)  { [weak self]  (tableView, indexPath, model) -> UITableViewCell? in
            switch model.displayType {
            case .default:
                guard let cell: MenuItemCell = tableView.automaticallyDequeueReusableCell(forIndexPath: indexPath) else {
                    return nil
                }
                cell.configure(model)
                return cell
                
            case .notice:
                guard let cell: VersionCell = tableView.automaticallyDequeueReusableCell(forIndexPath: indexPath) else {
                    return nil
                }
                cell.configure(model.title)
                return cell
                
            case .button:
                guard let cell: MenuButtonCell = tableView.automaticallyDequeueReusableCell(forIndexPath: indexPath) else {
                    return nil
                }
                cell.updateSOSButton(alertGroupCreated: self?.alertGroupCreated ?? false, numberOfAvailableDrivers: self?.numberOfAvailableDrivers ?? 0)
                cell.configure(model)
                return cell
                
            default: return nil
            }
            
        }
        return datasource
    }
}
