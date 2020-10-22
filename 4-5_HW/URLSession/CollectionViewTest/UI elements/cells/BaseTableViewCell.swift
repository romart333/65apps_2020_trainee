//
//  BaseTableViewCell.swift
//  URLSession
//
//  Created by Роман Капылов on 08/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewCell: UITableViewCell {
    class var cellIdentifier: String {
        return String(describing: self)
    }
}
