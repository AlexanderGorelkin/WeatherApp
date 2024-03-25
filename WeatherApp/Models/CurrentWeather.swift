//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation

// MARK: - CurrentWeatherModel
struct CurrentWeather: Decodable {
    let weather: [Weather]
    let base: String
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let timezone, id: Int
    let name: String
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}
