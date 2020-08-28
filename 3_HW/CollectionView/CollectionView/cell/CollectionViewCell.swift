//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Роман Копылов on 28.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var image: UIImageView!
    
    @IBOutlet private weak var firstLabel: UILabel!
    
    @IBOutlet private weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWith(model: Model) {
        self.image.image = model.image
        firstLabel.text = model.firstText
        secondLabel.text = model.secondText
    }
}
