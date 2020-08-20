//
//  User.swift
//  Lesson1
//
//  Created by Roman on 30/09/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

public class User {
    
    private(set) var name: String
    
    private(set) var secondName: String
    
    private(set) var phoneNumber: String
    
    init(_ name: String, _ secondName: String, _ phoneNumber: String) {
        self.name = name
        self.secondName = secondName
        self.phoneNumber = phoneNumber
    }
}
