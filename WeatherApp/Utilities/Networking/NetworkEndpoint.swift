//
//  NetworkEndpoint.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
enum Endpoint {
    case currentWeatherData(latitude: String, longitude: String)
    case forecast(latitude: String, longitude: String)
    case image(iconID: String)
    
    fileprivate var baseURL: URL {
        switch self {
        case .currentWeatherData, .forecast:
            URL(string: "https://api.openweathermap.org/data/2.5/")!
        case .image:
            URL(string: "https://openweathermap.org/")!
        }
    }
    
    fileprivate var path: String {
        switch self {
        case .currentWeatherData:
            "weather"
        case .forecast:
            "forecast"
        case .image(let iconID):
            "img/wn/\(iconID).png"
        }
    }
    var absoluteURL: URL? {
        let queryURL = baseURL.appendingPathComponent(self.path)
        guard var urlComponents = URLComponents(url: queryURL, resolvingAgainstBaseURL: true) else { return nil }
        switch self {
        case .currentWeatherData(let latitude, let longitude), .forecast(let latitude, let longitude):
            urlComponents.queryItems = [
                .init(name: "lat", value: latitude),
                .init(name: "lon", value: longitude),
                .init(name: "appid", value: NetworkConstants.apiKey),
                .init(name: "units", value: "metric"),
                .init(name: "lang", value: "ru")
            ]
        case .image: break
        }
        return urlComponents.url
    }
    
}
