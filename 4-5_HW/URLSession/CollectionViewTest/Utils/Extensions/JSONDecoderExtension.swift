//
//  JSONDecoderExtension.swift
//  URLSession
//
//  Created by Роман Копылов on 01.10.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

class JSONDecoderExtension {
    static func decode<T: Decodable>(data: Data, withDecodingStrategy decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decodingStrategy
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print(error)
        }
        return nil
    }
}
