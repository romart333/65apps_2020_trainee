//
//  AnswerViewController.swift
//  URLSession
//
//  Created by Роман Капылов on 09/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet private weak var questionTextView: UITextView!
    @IBOutlet private weak var tableView: UITableView!
    
    private var questionId: Int?
    private var question: String?
    private var items = [AnswerItem]()
    
    private var urlRequest: URLRequest? {
        guard let questionId = self.questionId else { return nil }
        let urlString = "https://api.stackexchange.com/2.2/questions/\(questionId)/answers?order=desc&sort=activity&site=stackoverflow&filter=!6JEV93ssVFAX9"
        guard let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        tableView.backgroundColor = .systemGray6
        
        questionTextView.attributedText = question?.getNSAttributedString()
        let nib = UINib(nibName: AnswerTableViewCell.cellIdentifier, bundle: nil)
        tableView.register(
            nib,
            forCellReuseIdentifier: AnswerTableViewCell.cellIdentifier)
        self.fetchAnswers()
    }
    
    static func initAnswerVC(
        withQuestion question: String?,
        andQuestionId questionId: Int?) -> AnswerViewController? {
        if let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(
                identifier: String(describing: self)) as? AnswerViewController {
            vc.questionId = questionId
            vc.question = question
            return vc
        }
        return nil
    }
    
    func fetchAnswers() {
        guard let urlRequest = self.urlRequest else { return }
        APIService.shared.getData(request: urlRequest) { [weak self] result in
            switch result {
            case .success(let data):
                let decodedResponse: AnswerResponse? = JSONDecoderExtension.decode(data: data)
                guard let answerItems = decodedResponse?.items else { return }
                DispatchQueue.main.async {
                    self?.realoadTableView(withItems: answerItems)
                }
            case .failure(let error):
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    UIAlertControllerHelper.showAlert(
                        withTitle: error.rawValue,
                        inViewController: strongSelf)
                }
            }
        }
    }
    
    func realoadTableView(withItems items: [AnswerItem]) {
        self.items = items
        tableView.reloadData()
    }
}

extension AnswerViewController: UITableViewDelegate {
    
}

extension AnswerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AnswerTableViewCell.cellIdentifier,
            for: indexPath) as? AnswerTableViewCell else { return UITableViewCell() }
        if (0..<items.count).contains(indexPath.row) {
            cell.configureCell(withAnswer: items[indexPath.row])
        }
        return cell
    }
}
