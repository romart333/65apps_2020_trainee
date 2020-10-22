//
//  Owner+CoreDataClass.swift
//  URLSession
//
//  Created by Роман Капылов on 07/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//
//

import Foundation
import CoreData


public class Owner: NSManagedObject, Decodable {
    
    enum CodingKeys: CodingKey {
        case displayName
    }
    
    required convenience public init(from decoder: Decoder) throws {
        self.init(context: PersistanceService.shared.context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.displayName = try? container.decode(String.self, forKey: .displayName)
    }
}
