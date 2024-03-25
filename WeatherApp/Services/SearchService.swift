//
//  SearchService.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import Foundation
import MapKit
final class SearchService: NSObject {
    private let searchCompleter = MKLocalSearchCompleter()
    @Published private(set) var searchResults = [MKLocalSearchCompletion]()
    @Published var searchedCoordinate: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
    }
    func search(with searchText: String) {
        searchCompleter.queryFragment = searchText
    }
    func getSearchLocation(by indexPath: IndexPath) {
        let searchRequest = MKLocalSearch.Request(completion: searchResults[indexPath.row])
        MKLocalSearch(request: searchRequest).start { (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.location?.coordinate else { return }
            self.searchedCoordinate = coordinate
        }
    }
}
extension SearchService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
    }
}
