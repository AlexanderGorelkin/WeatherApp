//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
enum NetworkError: LocalizedError {
    case invalidURL
    case badURLResponce(url: URL)
    case unknown
    case serverError(error: String)
    var errorDescription: String? {
        switch self {
        case .badURLResponce(let url): return "[🔥]Плохой ответ от сервера: \(url)"
        case .unknown: return "[⚠️]Неизвестная оишбка"
        case .serverError(let error): return "Ошибка на сервере" + error
        case .invalidURL: return "Некоректная ссылка"
        }
    }
}
