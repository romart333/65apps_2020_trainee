//
//  ViewController.swift
//  2
//
//  Created by Роман Капылов on 09/08/2020.
//  Copyright © 2020 Роман Капылов. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var wkWebView: WKWebView!
    @IBOutlet private weak var textLabel: UILabel!
    private var isImageViewHidden = true
    private var isWkWebViewHidden = true
    private var isTextLabelHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restoreState()
    }
    
    func setAppLaunchMode(appLaunchMode: ApplicationLaunchMode) {
        switch appLaunchMode {
        case .showText(let text):
            showTextLabel(withText: text)
        case .openURL(let url):
            showWebView(withURL: url)
            self.view = wkWebView
        case .showImage:
            showImageView()
        }
    }
    
    func showTextLabel(withText text: String) {
        imageView.isHidden = true
        wkWebView.isHidden = true
        textLabel.isHidden = false
        self.textLabel.text = text
        saveState()
    }
    
    func showWebView(withURL url: URL) {
        imageView.isHidden = true
        wkWebView.isHidden = false
        textLabel.isHidden = true
        let request = URLRequest(url: url)
        wkWebView.load(request)
        saveState()
    }
    
    func showImageView() {
        imageView.isHidden = false
        wkWebView.isHidden = true
        textLabel.isHidden = true
        saveState()
    }
    
    func saveState() {
        isImageViewHidden = imageView.isHidden
        isWkWebViewHidden = wkWebView.isHidden
        isTextLabelHidden = textLabel.isHidden
    }
    
    func restoreState() {
        imageView.isHidden = isImageViewHidden
        wkWebView.isHidden = isWkWebViewHidden
        textLabel.isHidden = isTextLabelHidden
    }
}

