//
//  Owner+CoreDataProperties.swift
//  URLSession
//
//  Created by Роман Капылов on 09/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//
//

import Foundation
import CoreData


extension Owner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Owner> {
        return NSFetchRequest<Owner>(entityName: "Owner")
    }

    @NSManaged public var displayName: String?

}
