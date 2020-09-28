//
//  ContainerViewController.swift
//  URLSession
//
//  Created by Роман Капылов on 27/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private var contentViewController: ContentViewController!
    private var slideBarController: SlideBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentViewController()
        // Do any additional setup after loading the view.
    }
    
    func configureContentViewController() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? ContentViewController {
            //        viewController.delegate = self
            contentViewController = viewController
            addChild(contentViewController)
            view.addSubview(contentViewController.view)
            contentViewController.didMove(toParent: self)
            contentViewController.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:))))
        }
    }
    
    func configureSlideBarController() {
        if slideBarController == nil {
            slideBarController = SlideBarController()
            addChild(slideBarController)
            view.insertSubview(slideBarController.view, at: 0)
            slideBarController.didMove(toParent: self)
        }
    }
    
    @objc func handlePanGesture(gesture:UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            
            print("began")
        case .changed:
            print("changed")
        default:
            // 
            break
        }
    }
    
    func showSlideBarViewController(shouldMove: Bool) {
        if shouldMove {
            // показываем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.contentViewController.view.frame.origin.x = self.contentViewController.view.frame.width - 140
            }) { (finished) in
                
            }
        } else {
            // убираем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.contentViewController.view.frame.origin.x = 0
            }) { (finished) in
                
            }
        }
    }
}


