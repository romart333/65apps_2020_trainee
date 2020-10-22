//
//  StringExtenstion.swift
//  URLSession
//
//  Created by Роман Капылов on 09/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

extension String {
    func getNSAttributedString() -> NSAttributedString? {
        let data = Data(self.utf8)
        return try? NSAttributedString(
            data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue ],documentAttributes: nil)
    }
}
