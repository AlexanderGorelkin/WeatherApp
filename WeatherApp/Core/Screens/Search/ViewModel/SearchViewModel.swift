//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Combine
import Foundation
import MapKit
final class SearchViewModel {
    @Published var searchString: String = ""
    var reloadTableView: (() -> Void)?
    var setupTempView: (() -> Void)?
    var searchArray: [CityCellViewModel] = [] {
        didSet {
            reloadTableView?()
        }
    }
    var currentWeather = [TempViewModel]() {
        didSet {
            setupTempView?()
        }
    }
    private var validString:  AnyPublisher<String, Never> {
        $searchString
            .debounce(for: 0.1, scheduler: RunLoop.main)
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    private var weatherService: WeatherService?
    private let searchService = SearchService()
    private var cancellables = Set<AnyCancellable>()
    init()  {
        addSub()
    }
    private func addSub() {
        validString
            .sink { searchText in
                self.searchService.search(with: searchText)
                
            }
            .store(in: &cancellables)
        searchService.$searchResults
            .map(transformToCellViewModel)
            .sink { [weak self] searchedArray in
                self?.searchArray = searchedArray
            }
            .store(in: &cancellables)
        searchService.$searchedCoordinate
            .sink { [weak self] location in
                guard let location = location,
                      let self = self else { return }
                self.weatherService = WeatherService(latitude: location.latitude.toString, longitude: location.longitude.toString)
                self.getWeatherData()
            }
            .store(in: &cancellables)
    }
    
    private func transformToCellViewModel(_ array: [MKLocalSearchCompletion]) -> [CityCellViewModel] {
        return array.compactMap { .init(cityName: $0.title) }
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        searchService.getSearchLocation(by: indexPath)
    }
    
    private func getWeatherData() {
        Task {
            do {
                let current = try await self.weatherService!.getCurrentData()
                await mapCurrentData(current: current)
            } catch(let error) {
                print(error)
            }
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
}

