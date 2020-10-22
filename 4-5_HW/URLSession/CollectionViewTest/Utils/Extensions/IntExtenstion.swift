//
//  Int.swift
//  URLSession
//
//  Created by Роман Капылов on 06/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

extension Int {
    func toDateString(dateStyle: DateFormatter.Style = .long) -> String {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter1 = DateFormatter()
        formatter1.dateStyle = dateStyle
        return formatter1.string(from: date)
    }
}
