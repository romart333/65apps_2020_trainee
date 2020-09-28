//
//  CustomCollectionViewCell.swift
//  CollectionViewTest
//
//  Created by Роман Копылов on 15.09.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
