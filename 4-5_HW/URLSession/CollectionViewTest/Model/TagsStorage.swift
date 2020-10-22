//
//  TagsStorage.swift
//  URLSession
//
//  Created by Роман Капылов on 27/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

class TagsStorage {
    
    private let tags = ["objective-c", "swift", "ios", "xcode", "cocoa-touch", "iphone"]
    
    private init() {}
  
    static var shared: TagsStorage = TagsStorage()
    
    func getTagWithIndex(index: Int) -> String? {
        if (0..<tags.count).contains(index) {
            return tags[index]
        }
        
        return nil
    }
    
    func getDefaultTag() -> String? {
        if tags.count > 0 {
            return tags[0]
        }
        
        return nil
    }
    
    func getCount() -> Int {
        return tags.count
    }
}
