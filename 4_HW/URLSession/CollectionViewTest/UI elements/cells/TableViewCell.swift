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
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastModifiedDateLabel: UILabel!
    @IBOutlet private weak var questionsCountLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    
    static var cellIdentifier: String {
        return String(describing: self)
    }

    func configureCellWith(item: QuestionItem) {
        
        nameLabel.text = item.title
        
        var lastModifiedDate = "Дата модификации: "
        if let editDate = item.lastEditDate {
            let timeInterval = TimeInterval(editDate)
            let date = Date(timeIntervalSince1970: timeInterval)
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .long
            lastModifiedDate += formatter1.string(from: date)
        }
        lastModifiedDateLabel.text = lastModifiedDate
        
        questionsCountLabel.text = "Количество ответов: \(item.answerCount)"
        
        var author = "Автор: "
        if let displayName = item.owner.displayName {
            author += displayName
        }
        authorLabel.text = author
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        lastModifiedDateLabel.text = nil
        questionsCountLabel.text = nil
        authorLabel.text = nil
    }
}
