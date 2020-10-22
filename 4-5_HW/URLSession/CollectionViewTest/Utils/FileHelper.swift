//
//  File.swift
//  URLSession
//
//  Created by Роман Копылов on 01.10.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation

class FileHelper {
    static func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    /// Генерирует URL файла в documents directory. Именем файла является хэш от входного параметра byNetworkStringUrl
    static func getFileUrl(byNetworkStringUrl stringUrl: String) -> URL {
        let fileName = HashHelper.getHash(sourceValue: stringUrl)
        return FileHelper.getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    static func saveDataToFile(data: Data,
                        byUrl url: URL) {
        let absoluteStringUrl = url.absoluteString
        let fileUrl = FileHelper.getFileUrl(byNetworkStringUrl: absoluteStringUrl)
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            print("cREATE file!")
            FileManager.default.createFile(atPath: fileUrl.path,
                                           contents: data,
                                           attributes: nil)
            UserDefaults.standard.setValue(Date(), forKey: absoluteStringUrl)
        } else {
            do {
                print("write to file!")
                try data.write(to: fileUrl, options: .atomic)
                UserDefaults.standard.setValue(Date(), forKey: absoluteStringUrl)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    /// Возвращает данные из файла,  если кеш еще валидный
    static func getValidItemsFromFile(forNetworkUrl url: URL) -> (Result<Response?, Error>)? {
        let stringUrl = url.absoluteString
        guard let date = UserDefaults.standard.value(forKey: stringUrl) as? Date else { return nil }
        if !Cache.isValidCache(cacheDate: date) {
            return nil
        }
        
        let fileUrl = FileHelper.getFileUrl(byNetworkStringUrl: stringUrl)
        let dataResult = getDataFromFile(byFileUrl: fileUrl)
        
        switch dataResult {
        case .success(let data):
            return .success(JSONDecoderExtension.decode(data: data))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    static func getDataFromFile(byFileUrl fileUrl: URL) -> Result<Data, Error> {
        do {
            print("Refresh table from file")
            let data = try Data(contentsOf: fileUrl)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
