//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
final class NetwrokManager {
    func fetchData(endpoint: Endpoint) async throws -> Data {
        let urlRequest = try await createRequest(endpoint: endpoint, method: .get)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let responce = response as? HTTPURLResponse,
              responce.statusCode >= 200 && responce.statusCode < 300 else {
            throw NetworkError.badURLResponce(url: urlRequest.url!)
        }
        return data
    }
    private func createRequest(endpoint: Endpoint, method: Method) async throws -> URLRequest {
        guard let url = endpoint.absoluteURL else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
