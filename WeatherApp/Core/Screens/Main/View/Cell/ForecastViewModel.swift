//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
struct ForecastViewModel {
    let date: String
    let time: String
    let imageName: String
    let temp: String
    func getIcon() async -> UIImage {
        return await IconService.getCoinImage(imageName: imageName)
    }
}
