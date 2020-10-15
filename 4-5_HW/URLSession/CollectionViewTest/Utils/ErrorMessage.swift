//
//  ErrorMessage.swift
//  URLSession
//
//  Created by Роман Капылов on 21/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//
import Foundation

enum ErrorMessage: String, Error {

    case invalidData = "Что-то пошло не так"
    case invalidResponse = "Ошибка сервера"
}
