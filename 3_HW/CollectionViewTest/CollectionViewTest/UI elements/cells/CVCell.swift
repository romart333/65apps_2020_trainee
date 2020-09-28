//
//  CVCell.swift
//  CollectionViewTest
//
//  Created by Роман Копылов on 15.09.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class CVCell : UICollectionViewCell, UIGestureRecognizerDelegate {
    
    static var cellIdentifier: String {
           return String(describing: self)
    }
    
    @IBOutlet private weak var imageView: UIImageView!

    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var textLabel: UILabel!
    
    var pan: UIPanGestureRecognizer!
//    var deleteLabel1: UILabel!
//    var deleteLabel2: UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
     }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        
//        let deleteText = "delete"
//        deleteLabel1 = UILabel()
//        deleteLabel1.text = deleteText
//        deleteLabel1.textColor = UIColor.black
//        self.insertSubview(deleteLabel1, belowSubview: self.contentView)
//
//        deleteLabel2 = UILabel()
//        deleteLabel2.text = deleteText
//        deleteLabel2.textColor = UIColor.white
//        self.insertSubview(deleteLabel2, belowSubview: self.contentView)

        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
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
    
    override func layoutSubviews() {
      super.layoutSubviews()

        if (pan.state == .changed) {
            let p: CGPoint = pan.translation(in: self)
            let width = self.contentView.frame.width
            let height = self.contentView.frame.height
            self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height)
//            self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
//            self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
        }
    }

    
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        switch pan.state  {
        case .began:
            break
        case .changed:
            self.setNeedsLayout()
        default:
            if abs(pan.velocity(in: self).x) > 500 {
                guard let cv = self.superview as? UICollectionView,
                      let indexPath =  cv.indexPathForItem(at: self.center),
                      let cvDelegate = cv.delegate else { return }
                cvDelegate.collectionView?(cv, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    print("animate")
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//
//           setNeedsLayout()
//           layoutIfNeeded()
//           let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//
//           var frame  = layoutAttributes.frame
//           frame.size.height = size.height
//           layoutAttributes.frame = frame
//               titleLabel.sizeToFit()
//           return layoutAttributes
//    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
          let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
          layoutIfNeeded()
          layoutAttributes.frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
          return layoutAttributes
      }
}
