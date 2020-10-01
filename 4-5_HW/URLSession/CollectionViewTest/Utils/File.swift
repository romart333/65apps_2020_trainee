//
//  File.swift
//  URLSession
//
//  Created by Роман Копылов on 01.10.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

class FileHelper {
    static func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
