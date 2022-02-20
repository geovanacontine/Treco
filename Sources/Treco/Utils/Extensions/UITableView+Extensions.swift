//
//  UITableView+Extensions.swift
//  PhotosApp
//
//  Created by Pedro Contine on 31/12/21.
//

import UIKit

public extension UITableView {
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    // swiftlint:disable force_cast
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func cellForComponent(_ component: UIView) -> UITableViewCell? {
        visibleCells.first { cell in
            let componentCell = cell as? TrecoComponentCell
            return componentCell?.component == component
        }
    }
    
    func indexPath(forComponent component: UIView) -> IndexPath? {
        guard let cell = cellForComponent(component) else {
            return nil
        }
        
        return indexPath(for: cell)
    }
    
    func dequeueComponentCell(component: UIView,
                              indexPath: IndexPath,
                              top: CGFloat = Spacing.xxxs.value,
                              left: CGFloat = Spacing.md.value,
                              bottom: CGFloat = Spacing.xxxs.value,
                              right: CGFloat = Spacing.md.value) -> TrecoComponentCell {
        
        let cell: TrecoComponentCell = dequeueReusableCell(indexPath: indexPath)
        
        let spacing = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        cell.render(component: component, spacing: spacing)
        
        return cell
    }
}
