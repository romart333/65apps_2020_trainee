//
//  ContainerViewController.swift
//  URLSession
//
//  Created by Роман Капылов on 27/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private weak var contentViewController: ContentViewController!
    private weak var slideBarController: SlideBarController!
    
    private var slideBarWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideBarWidth = self.view.frame.size.width / 2
        configureContentViewController()
        configureSlideBarController()
        self.contentViewController.slideBarController = slideBarController
        self.slideBarController?.delegate = self.contentViewController
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:))))
        // Do any additional setup after loading the view.
    }
    
    func configureContentViewController() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as? ContentViewController {
            //        viewController.delegate = self
            
            contentViewController = viewController
            let navController = UINavigationController(rootViewController: viewController)
            addChild(navController)
            view.addSubview(navController.view)
            navController.didMove(toParent: self)
        }
    }
    
    func configureSlideBarController() {
        if slideBarController == nil {
            let vc = SlideBarController()
            slideBarController = vc
            
            addChild(slideBarController)
            view.insertSubview(slideBarController.view, at: 1)
            slideBarController.didMove(toParent: self)
            
            slideBarController.view.frame = CGRect(
                           x: -slideBarWidth,
                           y: 0.0,
                           width: slideBarWidth,
                           height: self.view.frame.size.height)
            let slideBarFrame = slideBarController.view.frame
            slideBarController.setTableViewFrame(frame: CGRect(
                x: 0,
                y: 0,
                width: slideBarFrame.width,
                height: slideBarFrame.height))
        }
    }
    
    var prevXPanPosition: CGFloat = 0.0
    var currentXPanPosition: CGFloat = 0.0
    @objc func handlePanGesture(gesture:UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            prevXPanPosition = gesture.translation(in: self.view).x
            print("Start!!!:\(prevXPanPosition)")
        case .changed:
            let currentXPanPosition = gesture.translation(in: self.view).x
            let offset = currentXPanPosition - prevXPanPosition
            prevXPanPosition = currentXPanPosition
            let slideBarFrame = slideBarController.view.frame
            if (slideBarFrame.maxX + offset >= 0 &&
                slideBarFrame.maxX + offset <= slideBarWidth) {
                slideBarController.view.frame = slideBarFrame.offsetBy(
                    dx: offset,
                    dy: 0)
            }
//            print(offset)
//            print(slideBarController.view.frame)
        default:
            if slideBarController.view.frame.maxX >= slideBarWidth / 2 {
                changeSlideBarVisibility(toShow: true)
            } else {
                changeSlideBarVisibility(toShow: false)
            }
        }
    }
    
    func changeSlideBarVisibility(toShow: Bool) {
        var newOrigin: CGFloat = 0
        if !toShow {
            newOrigin = -slideBarWidth
        }
        print("New origin:\(newOrigin)")
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        if let self = self {
                            self.slideBarController.view.frame.origin.x = newOrigin
                        }
        }) { (finished) in
            
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEvent.EventSubtype.motionShake {
            print("Shake origin x:\(slideBarController.view.frame.origin.x)")
            let toShowSlideBar = slideBarController.view.frame.origin.x == -slideBarWidth
            changeSlideBarVisibility(toShow: toShowSlideBar)
        }
    }
}


