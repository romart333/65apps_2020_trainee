//
//  TableViewCell.swift
//  CollectionViewTest
//
//  Created by Роман Капылов on 19/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet private weak var myImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var myTextLabel: UILabel!
    
    static var cellIdentifier: String {
        return String(describing: self)
    }

    func configureCellWith(item: ItemModel) {
        myImageView.image = item.image
        titleLabel.text = item.title
        myTextLabel.text = item.text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        myTextLabel.text = nil
        myImageView.image = nil
    }
}
