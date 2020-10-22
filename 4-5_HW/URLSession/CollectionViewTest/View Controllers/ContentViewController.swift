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
        let urlString = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&tagged=\(tag)&site=stackoverflow&pagesize=\(pageSize)&filter=!9_bDDxJY5"
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupNavigationItems()
        setupActivityIndicator()
        
        if let defaultTag = TagsStorage.shared.getDefaultTag() {
            fetchQuestions(withTag: defaultTag)
        }
    }
    
    func setupNavigationItems() {
        let backBarButtonItem =  UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: nil,
            action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(
            title: showTagsText,
            style: .plain,
            target: self,
            action: #selector(togglePickerViewVisibilityFlag))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        isPickerViewShown = false
    }
    
    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        self.view.bringSubviewToFront(activityIndicator)
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
        
        guard let urlRequest = urlRequest,
            let url = urlRequest.url else {
            activityIndicator.stopAnimating()
            return
        }
        
        // ЗАГРУЗКА ДАННЫХ ИЗ CORE DATA
        if let response = PersistanceService
            .shared
            .getValidResponse(byNetworkUrl: url), let questionItems = response.questionItems {
            realoadTableView(withItems: Array(questionItems))
            return
        }
        
        // ЗАГРУЗКА ДАННЫХ ИЗ ФАЙЛА
//        if let result = FileHelper.getValidItemsFromFile(forNetworkUrl: url) {
//            switch result {
//            case .success(let response):
//                if let questionItems = response?.questionItems {
//                    realoadTableView(withItems: Array(questionItems))
//                    return
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        APIService.shared.getData(request: urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                let decodedResponse: Response? = JSONDecoderExtension.decode(data: data)
                guard let response = decodedResponse, let questionItems = response.questionItems else { return }
                
                DispatchQueue.main.async {
                    print("Refresh table from network\n")
                    self?.realoadTableView(withItems: Array(questionItems))
                }
                
                guard let url = urlRequest.url else { return }
                // СОХРАНЕНИЕ В CORE DATA
                PersistanceService.shared.saveResponse(
                    response: response,
                    withNetworkUrl: url)
                
                // СОХРАННИЕ В ФАЙЛ
//                FileHelper.saveDataToFile(data: data, byUrl: url)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    guard let strongSelf = self else { return }
                    UIAlertControllerHelper.showAlert(
                        withTitle: error.rawValue,
                        inViewController: strongSelf)
                }
            }
        }
    }
    
    func realoadTableView(withItems items: [QuestionItem]) {
        self.items = items
        tableView.reloadData()
        activityIndicator.stopAnimating()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.cellIdentifier, for: indexPath) as? QuestionTableViewCell else { return UITableViewCell() }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !(0..<items.count).contains(indexPath.row) {
            return
        }
        let item = items[indexPath.row]
        guard let questionBody = item.body,
              let answerVC = AnswerViewController.initAnswerVC(
                withQuestion: questionBody,
                andQuestionId: Int(item.questionId)) else { return }
        navigationController?.pushViewController(answerVC, animated: true)
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

