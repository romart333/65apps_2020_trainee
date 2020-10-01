//
//  ViewController.swift
//  1
//
//  Created by Роман Капылов on 09/08/2020.
//  Copyright © 2020 Роман Капылов. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let application = UIApplication.shared
    
     let secondAppUrlScheme = "second"
    
    @IBOutlet private weak var sendTextButton: UIButton!
    
    @IBOutlet private weak var sendURLButton: UIButton!
    
    @IBOutlet private weak var openImageButton: UIButton!
    
    @IBOutlet private weak var changeLanguageButton: UIButton!
    
    @IBAction func didTapSendText(_ sender: Any) {
        
        let text = "some random text"
        var urlComponents = URLComponents()
        urlComponents.scheme = secondAppUrlScheme;
        urlComponents.queryItems = [
            URLQueryItem(name: "text", value: text)
        ];
        
        guard let url = urlComponents.url, application.canOpenURL(url) else { return }
        application.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func didTapSendUrl(_ sender: Any) {
        
        let randUrl = "https://vk.com"
        var urlComponents = URLComponents()
        urlComponents.scheme = secondAppUrlScheme;
        urlComponents.queryItems = [
           URLQueryItem(name: "url", value: randUrl)
        ];
        
        guard let url = urlComponents.url, application.canOpenURL(url) else { return }
        application.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func didTapOpenImage(_ sender: Any) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = secondAppUrlScheme;
        urlComponents.queryItems = [
           URLQueryItem(name: "image", value: nil)
        ];
        
        guard let url = urlComponents.url, application.canOpenURL(url) else { return }
        application.open(url, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        }
    
     override func viewWillAppear(_ animated: Bool) {
        
           super.viewWillAppear(animated)
           updateLocalization()
    }
    
    func updateLocalization() {
        
        sendTextButton.setTitle("Send text".localizedString( comment: "Send text button"), for: .normal)
        sendURLButton.setTitle("Send URL".localizedString(comment: "Send url button"), for: .normal)
        openImageButton.setTitle("Open image".localizedString(comment: "Open image button"), for: .normal)
        changeLanguageButton.setTitle("Change language".localizedString(comment: "Change language button"), for: .normal)
        
        title = "Main".localizedString(comment: "Main VC title")
    }
}

