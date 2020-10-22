//
//  QuestionItem+CoreDataProperties.swift
//  URLSession
//
//  Created by Роман Капылов on 09/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionItem> {
        return NSFetchRequest<QuestionItem>(entityName: "QuestionItem")
    }

    @NSManaged public var answerCount: Int64
    @NSManaged public var lastEditDate: String?
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var questionId: Int64
    @NSManaged public var owner: Owner?

}
