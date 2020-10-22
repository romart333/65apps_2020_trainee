//
//  Response+CoreDataClass.swift
//  URLSession
//
//  Created by Роман Капылов on 07/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//
//

import Foundation
import CoreData


public class Response: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case questionItems = "items"
        case url = "url"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        self.init(context: PersistanceService.shared.context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try? container.decode(Date.self, forKey: .date)
        self.url = try? container.decode(URL.self, forKey: .url)
        self.questionItems = try container.decode(Set<QuestionItem>.self, forKey: .questionItems)
    }
}
