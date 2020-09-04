//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by Роман Копылов on 28.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CollectionViewCell"

    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var firstLabel: UILabel!
    
    @IBOutlet private weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWith(model: Model) {
        self.imageView.image = model.image
        firstLabel.text = model.firstText
        secondLabel.text = model.secondText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        firstLabel.text = nil
        secondLabel.text = nil
        imageView.image = nil
   }
}
