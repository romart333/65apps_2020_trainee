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

    private override init() {}
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
}
