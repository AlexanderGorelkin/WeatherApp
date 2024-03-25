//
//  SearchView.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class SearchView: UIViewController {
    
    private var viewModel = SearchViewModel()
    
    
    private lazy var searchBar = DefaultSearchBar(placeholder: "Москва")
    private lazy var tempView = TempView()
    private lazy var cityTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        return tableView
    }()
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupView()
        setupViewModel()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    private func setupView() {
        view.backgroundColor = .white
        view.addView(searchBar)
        view.addView(cityTableView)
        view.addView(tempView)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            cityTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            cityTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            cityTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            cityTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tempView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tempView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tempView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tempView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    @objc func dismissBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    private func setupTempView() {
        tempView.viewModel = viewModel.currentWeather[0]
    }
    
    private func setupViewModel() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.cityTableView.reloadData()
            }
        }
        viewModel.setupTempView = {
            DispatchQueue.main.async { [weak self] in
                self?.cityTableView.alpha = 0
                self?.tempView.alpha = 1
                self?.setupTempView()
            }
        }
    }
    
}
extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
        cell.cellViewModel =  viewModel.searchArray[indexPath.row]
        return cell
    }
    
    
}
extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath)
        searchBar.resignFirstResponder()
    }
}
extension SearchView: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.cityTableView.alpha = 1
        self.tempView.alpha = 0
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchString = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
