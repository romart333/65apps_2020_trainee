//
//  Runner.swift
//  Lesson1
//
//  Created by Roman on 30/09/2019.
//  Copyright © 2019 Roman. All rights reserved.
//

import Foundation

class Runner {
    
    private let consoleIO = ConsoleIO()
    
    private var userStorage = UserStorage()
    
    private enum OptionType: String{
        case show = "s"
        case add = "a"
        case delete = "d"
        case quit = "q"
        case unknown
        
        init(_ value: String) {
            switch value {
            case "s": self = .show
            case "a": self = .add
            case "d": self = .delete
            case "q": self = .quit
            default:  self = .unknown
            }
        }
    }
    
    private func getOption(_ option: String) -> (option: OptionType, value: String) {
        
        return (OptionType(option), option)
    }
    
    func run() {
        
        var shouldQuit = false
        while(!shouldQuit) {
            consoleIO.printUsage()
            let (option, value) = getOption(consoleIO.getInput())
            
            switch option {
            case .add:
                consoleIO.writeMessage("Enter user name:")
                let name = consoleIO.getInput()
                consoleIO.writeMessage("Enter user second name:")
                let secondName = consoleIO.getInput()
                consoleIO.writeMessage("Enter user phone number")
                let phoneNumber = consoleIO.getInput()
                let user = User(name, secondName, phoneNumber)
                userStorage.addUser(user)
            case .delete:
                consoleIO.writeMessage("Enter user number")
                let inputId = consoleIO.getInput()
                if let id = Int(inputId) {
                    let wasDeleted = userStorage.deleteUser(id)
                    if !wasDeleted { consoleIO.writeMessage("Incorrect user number was entered", to: .error)
                    }
                } else {
                    consoleIO.writeMessage("Incorrect input", to: .error)
                }
            case .show:
                let users = userStorage.getAllUsers()
                if (users.count == 0) {
                    consoleIO.writeMessage("There is no one user yet")
                    break;
                }
                
                for (index, user) in users.enumerated() {
                    consoleIO.writeMessage("User #\(index) - name:\(user.name), secondName:\(user.secondName), phoneNumber: \(user.phoneNumber)")
                }
            case .quit:
                shouldQuit = true
            default:
                consoleIO.writeMessage("Unknow command '\(value)'", to: .error)
                
            }
            
        }
    }
    
}
