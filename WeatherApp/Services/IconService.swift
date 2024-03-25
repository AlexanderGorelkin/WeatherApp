//
//  IconService.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class IconService {
    private static let localFileManager = LocalFileManager.shared
    static func getCoinImage(imageName: String) async -> UIImage {
        if let savedImage = LocalFileManager.shared.getImage(imageName: imageName, folderName: "weather_icons") {
            return savedImage
        } else {
            return await downloadCoinImage(imageName: imageName)
        }
    }
    private static func downloadCoinImage(imageName: String) async -> UIImage {
        let endpoint = Endpoint.image(iconID: imageName)
        do {
            let imageData = try await NetwrokManager().fetchData(endpoint: endpoint)
            let downloadedImage = UIImage(data: imageData)!
            localFileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: "weather_icons")
            return downloadedImage
        } catch {
            return UIImage(systemName: "flame")!
        }
    }
}
