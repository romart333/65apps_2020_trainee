//
//  UIAlertControllerExtension.swift
//  URLSession
//
//  Created by Роман Капылов on 09/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class UIAlertControllerHelper {
    static func showAlert(
        withTitle title: String,
        inViewController viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(ac, animated: true)
    }
}
