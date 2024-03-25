//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import CoreLocation
import Combine
import UIKit
final class MainViewModel {
    // MARK:  Services
    private let locationService = LocationService()
    private var weatherService: WeatherService?
    
    // MARK:  Closure
    var reloadTableView: (() -> Void)?
    var setupTempView: (() -> Void)?
    var showError: ((String) -> Void)?
   
    // MARK:  Combine
    private var cancellables = Set<AnyCancellable>()
    
    // MARK:  Data
    var forecastWeather = [ForecastViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var currentWeather = [TempViewModel]() {
        didSet {
            setupTempView?()
        }
    }
    
    init() {
        addSubscribers()
    }
    private func addSubscribers() {
        locationService.$currentLocation
            .sink { currentLocation in
                self.weatherService = WeatherService(latitude: currentLocation?.coordinate.latitude.toString ?? "55.763607",
                                                     longitude: currentLocation?.coordinate.longitude.toString ?? "37.599847")
                self.getWeatherData()
            }.store(in: &cancellables)
    }
    
    
    private func getWeatherData() {
        Task {
            do {
                let current = try await self.weatherService!.getCurrentData()
                let forecast = try await self.weatherService!.getForecastData()
                await mapForecastData(forecast: forecast)
                await mapCurrentData(current: current)
            } catch(let error) {
                guard let showError = showError else { 
                    print(error.localizedDescription)
                    return
                }
                showError(error.localizedDescription)
            }
        }
        
    }
    private func mapForecastData(forecast: Forecast) async {
        forecastWeather = forecast.list.map { list in
            ForecastViewModel(date: list.dt.fromUnixToDayAndMonth,
                              time: list.dt.fromUnixToHours,
                              imageName: list.weather[0].icon,
                              temp: list.main.feelsLike.toFormattedString)
        }
        
    }
    private func mapCurrentData(current: CurrentWeather) async {
        currentWeather = [.init(time: Date.now.dayOfWeek() + ", " + Date.now.hourdsAndMinutes,
                                city: current.name,
                                imageName: current.weather[0].icon,
                                temp: current.main.feelsLike.toFormattedString,
                                tempDescription: current.weather[0].description,
                                minMaxTemp: "Мин: " + current.main.tempMin.toFormattedString + "° Макс: " + current.main.tempMax.toFormattedString + "°",
                                wind: String(current.wind.speed),
                                humidity: String(current.main.humidity))
        ]
    }
    
    func tryAgain() {
        getWeatherData()
    }
    
    
}
