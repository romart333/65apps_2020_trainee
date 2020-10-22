//
//  TableViewCell.swift
//  CollectionViewTest
//
//  Created by Роман Капылов on 19/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class QuestionTableViewCell: BaseTableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastModifiedDateLabel: UILabel!
    @IBOutlet private weak var questionsCountLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!

    func configureCellWith(item: QuestionItem) {
        
        nameLabel.attributedText = item.title?.getNSAttributedString()
        
        let lastModifiedDate = "Дата модификации: "
        lastModifiedDateLabel.text = lastModifiedDate + (item.lastEditDate ?? "")
        
        questionsCountLabel.text = "Количество ответов: \(item.answerCount)"
        
        var author = "Автор: "
        if let displayName = item.owner?.displayName {
            author += displayName
        }
        authorLabel.text = author
        
    }
}
