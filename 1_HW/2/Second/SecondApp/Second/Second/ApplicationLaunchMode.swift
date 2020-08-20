//
//  LaunchAppMode.swift
//  Second
//
//  Created by Роман Копылов on 20.08.2020.
//  Copyright © 2020 Роман Капылов. All rights reserved.
//

import Foundation

enum ApplicationLaunchMode {
    case showText(text: String)
    case openURL(url: URL)
    case showImage
}
