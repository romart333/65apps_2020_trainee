//
//  ViewController.swift
//  2
//
//  Created by Роман Копылов on 24.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == self.textField {
            textLabel.text = self.textField.text
        }

        print("return")
        return true
    }

}

