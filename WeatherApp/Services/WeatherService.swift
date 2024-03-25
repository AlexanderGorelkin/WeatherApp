//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
final class WeatherService {
    private let networkManager = NetwrokManager()
    private let latitude: String
    private let longitude: String
    
    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }
    func getCurrentData() async throws -> CurrentWeather {
        let data = try await networkManager.fetchData(endpoint: .currentWeatherData(latitude: latitude, longitude: longitude))
        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
        return currentWeather
    }
    func getForecastData() async throws -> Forecast {
        let data = try await networkManager.fetchData(endpoint: .forecast(latitude: latitude, longitude: longitude))
        let currentWeather = try JSONDecoder().decode(Forecast.self, from: data)
        return currentWeather
    }
}
