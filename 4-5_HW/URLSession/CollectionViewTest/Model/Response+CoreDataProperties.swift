//
//  Response+CoreDataProperties.swift
//  URLSession
//
//  Created by Роман Капылов on 09/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//
//

import Foundation
import CoreData


extension Response {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Response> {
        return NSFetchRequest<Response>(entityName: "Response")
    }

    @NSManaged public var date: Date?
    @NSManaged public var url: URL?
    @NSManaged public var questionItems: Set<QuestionItem>?

}

// MARK: Generated accessors for questionItems
extension Response {

    @objc(addQuestionItemsObject:)
    @NSManaged public func addToQuestionItems(_ value: QuestionItem)

    @objc(removeQuestionItemsObject:)
    @NSManaged public func removeFromQuestionItems(_ value: QuestionItem)

    @objc(addQuestionItems:)
    @NSManaged public func addToQuestionItems(_ values: NSSet)

    @objc(removeQuestionItems:)
    @NSManaged public func removeFromQuestionItems(_ values: NSSet)

}
