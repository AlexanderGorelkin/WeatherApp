//
//  TempViewModel.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
struct TempViewModel {
    let time: String
    let city: String
    let imageName: String
    let temp: String
    let tempDescription: String
    let minMaxTemp: String
    let wind: String
    let humidity: String
    func getIcon() async -> UIImage {
        return await IconService.getCoinImage(imageName: imageName)
    }
}
