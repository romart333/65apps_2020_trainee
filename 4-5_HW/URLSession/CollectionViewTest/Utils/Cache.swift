//
//  Cache.swift
//  URLSession
//
//  Created by Роман Капылов on 07/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

class Cache {
    
    static let cacheLifeTimeInHours = 1
    
    static func isValidCache(cacheDate: Date) -> Bool {
        let diffComponents = Calendar.current.dateComponents(
            [.hour],
            from: cacheDate,
            to: Date())
        guard let hours = diffComponents.hour else { return false }
        return hours < cacheLifeTimeInHours
    }
}
