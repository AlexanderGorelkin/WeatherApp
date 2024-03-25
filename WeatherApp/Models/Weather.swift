//
//  Weather.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}
