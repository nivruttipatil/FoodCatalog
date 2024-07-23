//
//  UITableView + Extension.swift
//  FoodCatalog
//
//  Created by Nivrutti on 23/07/24.
//

import Foundation
import UIKit
extension UITableView {
    // MARK: Add empty message if no data in tableview
    func showEmptyMessage(text: String) {
        let lblMsg = UILabel(frame: self.frame)
        lblMsg.text = text
        lblMsg.font = FoodScreenTheme.Font.body
        lblMsg.textColor = .white
        lblMsg.textAlignment = .center
        lblMsg.tag = 1000
        self.addSubview(lblMsg)
    }
    // MARK: removing empty message from tableview
    func removeEmptyMessage() {
        _ = self.subviews.filter({ $0.tag == 1000 }).map({ $0.removeFromSuperview() })
    }
}

