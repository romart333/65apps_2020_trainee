//
//  PersistanceService.swift
//  URLSession
//
//  Created by Роман Капылов on 05/10/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import CoreData

class PersistanceService {
    
    private init() {}
    static let shared = PersistanceService()
    
    lazy var context = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "URLSession")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
     // MARK: - Работа с Response
    /// Возвращает Response с валидным кэшем по заданному networkUrl
    func getValidResponse(byNetworkUrl networkUrl: URL) -> Response? {
        
        guard let response = getResponse(byNetworkUrl: networkUrl),
              let date = response.date else { return nil }

        if !Cache.isValidCache(cacheDate: date) {
            return nil
        }
        
        return response
    }
    
    func getResponse(byNetworkUrl networkUrl: URL) -> Response? {
        
        let responses = getAllResponses().filter { response in
            if let responseUrl = response.url {
                return networkUrl == responseUrl
            }
            return false
        }
        return responses.count > 0 ? responses[0] : nil
    }
    
    func getAllResponses() -> [Response] {
        let request: NSFetchRequest<Response> = Response.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed")
        }
        return []
    }
    
    func saveResponse(response responseToSave: Response,
                      withNetworkUrl networkUrl: URL) {
        
        if let response = getResponse(byNetworkUrl: networkUrl) {
            print("update db! networkUrl.absoluteString")
            context.delete(response)
        }
        else  { print("insert into db! \(networkUrl.absoluteString)") }
        
        responseToSave.url = networkUrl
        responseToSave.date = Date()
        saveContext()
    }
}
