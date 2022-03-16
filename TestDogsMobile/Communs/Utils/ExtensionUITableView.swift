//
//  ExtensionUITableView.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
import UIKit
public extension UITableView {
    var contentSizeHeight: CGFloat {
        var height = CGFloat(0)
        for section in 0..<numberOfSections {
            height += rectForHeader(inSection: section).height
            let rows = numberOfRows(inSection: section)
            for row in 0..<rows {
                height += rectForRow(at: IndexPath(row: row, section: section)).height
            }
        }
        return height
    }
}
