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
    var currentSnapShot: SnapShot!
    func applySnapshot(in dataSource: DataSource, animatingDifferences: Bool = true) {
        currentSnapShot = dataSource.snapshot()
        currentSnapShot.deleteSections(currentSnapShot.sectionIdentifiers)
        currentSnapShot.deleteAllItems()
        currentSnapShot.appendSections([.main])
        currentSnapShot.appendItems(items, toSection: .main)
        dataSource.apply(currentSnapShot, animatingDifferences: animatingDifferences) {
            print("osiuvno")
        }
    }
    
    func dataSource(for tableView: UITableView) -> DataSource {
        let datasource = DataSource(tableView: tableView)  { (tableView, indexPath, model) -> UITableViewCell? in
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
            }
        }
        return datasource
    }
}
