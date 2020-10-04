//
//  HashHelper.swift
//  URLSession
//
//  Created by Роман Капылов on 03/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import CryptoKit

class HashHelper {
    class func getHash(sourceValue: String) -> String {
        let data = Data(sourceValue.utf8)
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
}
