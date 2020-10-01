//
//  Language.swift
//  First
//
//  Created by Роман Капылов on 16/08/2020.
//  Copyright © 2020 Роман Капылов. All rights reserved.
//

import Foundation

class LocalizationManager {
    
    private var currentLanguage = Language.English
    
    static var shared: LocalizationManager = {
        let instance = LocalizationManager()
        return instance
    }()
    
    func setCurrentLocalization(language: Language) {
        self.currentLanguage = language
    }
    
    func getCurrentLocalization() -> Language {
        return currentLanguage
    }
    
    func getAllLocalizations() -> [Language] {
        return Language.allCases
    }
    
    private init() { }
}
