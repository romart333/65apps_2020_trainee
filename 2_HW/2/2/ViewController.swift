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
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = textView.text
        textView.delegate = self
    }
}

extension ViewController: UITextViewDelegate {

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textLabel.text = textView.text
    }
}

