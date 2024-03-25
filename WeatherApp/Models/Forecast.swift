//
//  Forecast.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
struct Forecast: Decodable {
    let message, cnt: Int
    let list: [List]
}


// MARK: - List
struct List: Decodable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let pop: Double
}
