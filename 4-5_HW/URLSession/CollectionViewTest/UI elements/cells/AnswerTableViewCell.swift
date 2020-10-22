//
//  AnswerTableViewCell.swift
//  URLSession
//
//  Created by Роман Капылов on 09/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class AnswerTableViewCell: BaseTableViewCell {

    @IBOutlet private weak var bodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(withAnswer answer: AnswerItem) {
        backgroundColor = .systemGray6
        bodyLbl.attributedText = answer.body?.getNSAttributedString()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
