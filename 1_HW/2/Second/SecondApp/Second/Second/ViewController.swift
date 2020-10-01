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

    private var appLaunchMode: ApplicationLaunchMode?
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var wkWebView: WKWebView!
    @IBOutlet private weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch appLaunchMode {
        case .showText(let text):
            showTextLabel(withText: text)
        case .openURL(let url):
            showWebView(withURL: url)
            self.view = wkWebView
        case .showImage:
            showImageView()
        default:
            showTextLabel(withText: "Init from this app")
        }
        // Do any additional setup after loading the view.
    }
    
    func setAppLaunchMode(mode: ApplicationLaunchMode) {
        self.appLaunchMode = mode
    }
    
    func showTextLabel(withText text: String) {
        imageView.isHidden = true
        wkWebView.isHidden = true
        textLabel.isHidden = false
        self.textLabel.text = text
    }
    
    func showWebView(withURL url: URL) {
        imageView.isHidden = true
        wkWebView.isHidden = false
        textLabel.isHidden = true
        let request = URLRequest(url: url)
        wkWebView.load(request)
    }
    
    func showImageView() {
        imageView.isHidden = false
        wkWebView.isHidden = true
        textLabel.isHidden = true
    }
}

