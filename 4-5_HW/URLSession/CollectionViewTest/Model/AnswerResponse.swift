//
//  AnswerResponse.swift
//  URLSession
//
//  Created by Роман Капылов on 08/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

struct AnswerResponse: Decodable {
    let items: [AnswerItem]?
}
