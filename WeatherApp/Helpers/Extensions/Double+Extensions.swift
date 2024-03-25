//
//  Double+Extensions.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
extension Double {
    var toFormattedString: String {
        return String(format: "%.0f", self)
    }
    var fromUnixToDayAndMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
    var fromUnixToHours: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date(timeIntervalSince1970: self))
    }
}
