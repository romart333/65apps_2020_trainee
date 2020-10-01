//
//  APIService.swift
//  URLSession
//
//  Created by Роман Капылов on 21/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

class APIService: NSObject, URLSessionDataDelegate {
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()

    private override init() {
        super.init()
    }
    static let shared = APIService()

    private let okStatusCodes = (200...299)
    private let pageSize = 50
    private var receivedData: Data? = Data()
    private var completion: ((Result<Data, ErrorMessage>) -> Void)?
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let err = error {
            print("Error: \(err.localizedDescription)")
            self.completion?(.failure(.invalidData))
        }
        
        if let data = self.receivedData {
            self.completion?(.success(data))
        }
        self.receivedData?.removeAll()
     }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: (URLSession.ResponseDisposition) -> Void) {
        
        guard let response = response as? HTTPURLResponse, okStatusCodes.contains(response.statusCode) else {
            completionHandler(.cancel)
            return
        }
        completionHandler(.allow)
    }

     func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.receivedData?.append(data)
     }
    
    func getData(request: URLRequest, completion: @escaping (Result<Data, ErrorMessage>) -> Void) {
        self.completion = completion
        let task = self.session.dataTask(with: request)
        task.resume()
    }
    
//    func getData(tag: String, completed: @escaping (Result<[QuestionItem], ErrorMessage>) -> Void) {
//        let urlString = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&tagged=\(tag))&site=stackoverflow&pagesize=\(pageSize)"
//        guard let url = URL(string: urlString) else {return}
//        let task = self.session.dataTask(with: url) { [weak self] (data, response, error) in
//            guard let strongSelf = self else { return }
//            if let _ = error {
//                print(error)
//                completed(.failure(.invalidData))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, strongSelf.okStatusCodes.contains(response.statusCode) else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let deconder = JSONDecoder()
//                deconder.keyDecodingStrategy = .convertFromSnakeCase
//
//                let json = try? deconder.decode(Items.self, from: data)
//                guard let results = json else {
//                    throw ErrorMessage.invalidData
//                }
//                DispatchQueue.main.async {
//                    completed(.success(results.items))
//                }
//            } catch {
//                print(error)
//                completed(.failure(.invalidData))
//            }
//        }
//
//        task.resume()
//    }
}
