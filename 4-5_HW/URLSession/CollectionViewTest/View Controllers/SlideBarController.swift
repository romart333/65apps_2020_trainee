//
//  SlideBarController.swift
//  URLSession
//
//  Created by Роман Капылов on 27/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

protocol SlideBarControllerDelegate {
    func fetchQuestions(withTag tag: String)
}

class SlideBarController: UIViewController {

    var delegate: SlideBarControllerDelegate?
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        tableView.backgroundColor = .darkGray
    }
    
    func setTableViewFrame(frame: CGRect) {
        tableView.frame = frame
    }
}

extension SlideBarController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TagsStorage.shared.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = TagsStorage.shared.getTagWithIndex(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tag = TagsStorage.shared.getTagWithIndex(index: indexPath.row) {
            delegate?.fetchQuestions(withTag: tag)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
