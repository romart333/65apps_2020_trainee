//
//  UserStorage.swift
//  Lesson1
//
//  Created by Roman on 30/09/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class UserStorage {
    
    private var users = [User]()
    
    func getAllUsers() -> [User] {
        return users
    }
    
    func addUser(_ user: User) {
        users.append(user)
    }
    
    func deleteUser(_ id: Int) -> Bool {
        if (users.count <= id || id < 0) {
            return false
        }
        
        users.remove(at: id)
        return true
    }
}
