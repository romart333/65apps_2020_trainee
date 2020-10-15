//
//  ContentViewController.swift
//  URLSession
//
//  Created by Роман Капылов on 27/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, SlideBarControllerDelegate {
    
    weak var slideBarController: SlideBarController?
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let showTagsText = "Show tags"
    private let hideTagsText = "Hide tags"
    
    private var isPickerViewShown: Bool!
    
    @IBOutlet private weak var tableViewToSafeAreConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tableViewToPickerConstraint: NSLayoutConstraint!
    @IBOutlet private var pickerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    private var items = [QuestionItem]()
    private var tag = String()
    private let pageSize = 50
    
    private var urlRequest: URLRequest? {
        let urlString = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&tagged=\(tag)&site=stackoverflow&pagesize=\(pageSize)"
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self

        
        let barButtonItem = UIBarButtonItem(title: showTagsText, style: .plain, target: self, action: #selector(togglePickerViewVisibilityFlag))
        self.navigationItem.leftBarButtonItem = barButtonItem
        isPickerViewShown = false
        
        activityIndicator.hidesWhenStopped = true
        self.view.bringSubviewToFront(activityIndicator)
        
        if let defaultTag = TagsStorage.shared.getDefaultTag() {
            fetchQuestions(withTag: defaultTag)
        }
    }
    
    @objc func togglePickerViewVisibilityFlag() {
        isPickerViewShown = !isPickerViewShown
        setupPickerViewVisibility()
    }
    
    func setupPickerViewVisibility() {
        if let barButtonItem = self.navigationItem.leftBarButtonItem {
            barButtonItem.title = isPickerViewShown ? hideTagsText : showTagsText
            
            pickerViewHeightConstraint.isActive = isPickerViewShown
            tableViewToSafeAreConstraint.isActive = !isPickerViewShown
            tableViewToPickerConstraint.isActive = isPickerViewShown
        }
    }
    
    
    func fetchQuestions(withTag tag: String) {
        activityIndicator.startAnimating()
        self.tag = tag
        self.title = tag
        guard let urlRequest = urlRequest else {
            activityIndicator.stopAnimating()
            return
        }
        
        APIService.shared.getData(request: urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                let deconder = JSONDecoder()
                deconder.keyDecodingStrategy = .convertFromSnakeCase

                let decodedItems = try? deconder.decode(Items.self, from: data)
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
                guard let resultItems = decodedItems else { return }
                DispatchQueue.main.async {
                    self?.items = resultItems.items
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    let ac = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(ac, animated: true)
                }
            }
        }
    }
}

extension ContentViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        if (0..<items.count).contains(indexPath.row) {
            let item = items[indexPath.row]
            cell.configureCellWith(item: item)
        }
        return cell
    }
}

extension ContentViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
}

extension ContentViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        TagsStorage.shared.getCount()
    }
}

extension ContentViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        TagsStorage.shared.getTagWithIndex(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let tag = TagsStorage.shared.getTagWithIndex(index: row) else { return }
        fetchQuestions(withTag: tag)
    }
}

