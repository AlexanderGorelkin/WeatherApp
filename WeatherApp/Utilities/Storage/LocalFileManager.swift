//
//  LocalFileManager.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
class LocalFileManager {
    static let shared = LocalFileManager()
    private init() { }
    
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFolderIfNeeded(folderName: folderName)
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else { return }
        do {
            try data.write(to: url)
        } catch( let error) {
            print("Error saving image: \(error.localizedDescription). Image: \(imageName)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) else { return nil }
        return UIImage(contentsOfFile: url.path(percentEncoded: true))
        
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path(percentEncoded: true)) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch(let error) {
                print("Error creating directory: \(error.localizedDescription) with FolderName: \(folderName)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName, conformingTo: .application)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName, conformingTo: .application)
    }
    
}
