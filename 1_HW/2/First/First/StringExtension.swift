//
//  StringExtension.swift
//  First
//
//  Created by Роман Капылов on 19/08/2020.
//  Copyright © 2020 Роман Капылов. All rights reserved.
//

import Foundation

extension String {
    
    func localizedString(comment: String) -> String {
        
        let locallizationCode = LocalizationManager.shared.getCurrentLocalization().rawValue
        
        if let path = Bundle.main.path(forResource: locallizationCode, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil,
                                     bundle: bundle, value: "", comment: "")
        }
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
