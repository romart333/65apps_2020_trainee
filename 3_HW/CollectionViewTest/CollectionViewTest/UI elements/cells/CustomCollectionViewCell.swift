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
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellWith(item: ItemModel) {
        self.imageView.image = item.image
        titleLabel.text = item.title
        textLabel.text = item.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        textLabel.text = nil
        imageView.image = nil
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        layoutAttributes.frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}
