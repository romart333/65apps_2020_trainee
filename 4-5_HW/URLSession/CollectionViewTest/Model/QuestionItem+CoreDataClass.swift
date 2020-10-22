//
//  QuestionItem+CoreDataClass.swift
//  URLSession
//
//  Created by Роман Капылов on 07/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//
//

import Foundation
import CoreData


public class QuestionItem: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case answerCount, lastEditDate, title, body, owner, questionId
    }
    
    required convenience public init(from decoder: Decoder) throws {
        self.init(context: PersistanceService.shared.context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let lastEditDate = try? container.decode(
            Int.self,
            forKey: .lastEditDate) {
            self.lastEditDate = lastEditDate.toDateString()
        }
        
        self.body = try? container.decode(String.self, forKey: .body)
        self.title = try? container.decode(String.self, forKey: .title)
        self.owner = try? container.decode(Owner.self, forKey: .owner)
        self.answerCount = try container.decode(Int64.self, forKey: .answerCount)
        self.questionId = try container.decode(Int64.self, forKey: .questionId)
       
    }
}
