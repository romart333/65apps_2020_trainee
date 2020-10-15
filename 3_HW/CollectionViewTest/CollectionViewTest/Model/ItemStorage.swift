//
//  ItemStorage.swift
//  CollectionViewTest
//
//  Created by Роман Капылов on 19/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class ItemStorage {
    
    private var sectionsWithItems = [Int: [ItemModel]]()
    
    var sectionsCount: Int {
        return sectionsWithItems.count
    }
    
    private init() {}
    
    static var shared: ItemStorage = {
        let instance = ItemStorage()
        return instance
    }()
    
    func getItemsBy(section: Int) -> [ItemModel]? {
        return sectionsWithItems[section]
    }
    
    func setItemsFor(section: Int, withItems items: [ItemModel]) {
        sectionsWithItems[section] = items
    }
    
    func removeItemAt(section: Int, withItemIndex itemIndex:Int) {
        sectionsWithItems[section]?.remove(at: itemIndex)
    }
}
