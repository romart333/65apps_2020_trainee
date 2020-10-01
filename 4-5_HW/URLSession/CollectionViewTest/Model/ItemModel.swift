//
//  File.swift
//  CollectionView
//
//  Created by Роман Копылов on 28.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

struct Items: Codable {
    let items: [QuestionItem]
    var url: URL?
}

struct QuestionItem: Codable {
    var title: String
    var lastEditDate: Int?
    var answerCount: Int
    var owner: Owner
}

struct Owner: Codable {
    var displayName: String?
}
