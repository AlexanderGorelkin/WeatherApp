//
//  MainView.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit
final class MainView: UIViewController {
    private var viewModel = MainViewModel()
    
    // MARK:  Subviews
    private lazy var loaderView = DefaultLoader()
    private lazy var searchButton = {
        var conf = UIButton.Configuration.tinted()
        conf.baseBackgroundColor = .gray
        conf.image = UIImage(systemName: "magnifyingglass")
        conf.cornerStyle = .capsule
        let button = UIButton(configuration: conf)
        button.addTarget(self, action: #selector(didTapSearchBtn), for: .touchUpInside)
        return button
    }()
    private lazy var tempView = TempView()
    private lazy var forecastCollection = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.indetifier)
        return collectionView
    }()
    // MARK:  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setupViewModel()
        setupView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK:  setup ViewModel
    private func setupViewModel() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.forecastCollection.reloadData()
            }
        }
        viewModel.setupTempView = {
            DispatchQueue.main.async { [weak self] in
                self?.setupTempView()
                self?.loaderView.removeFromSuperview()
            }
        }
        viewModel.showError = { error in
            DispatchQueue.main.async { [weak self] in
                self?.showError(error: error)
            }
        }
    }
    private func setupTempView() {
        tempView.viewModel = viewModel.currentWeather[0]
    }
    private func showError(error: String) {
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "ok", style: .cancel)
        let tryAgainAction = UIAlertAction(title: "try again", style: .default) { [weak self] _ in
            self?.viewModel.tryAgain()
        }
        alert.addAction(alertAction)
        alert.addAction(tryAgainAction)
        present(alert, animated: true)
    }
    
    
    // MARK:  setup ViewController
    private func setupView() {
        view.addView(loaderView)
        
        view.addView(tempView)
        view.addView(forecastCollection)
        tempView.addView(searchButton)
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.heightAnchor.constraint(equalToConstant: 10),
            loaderView.widthAnchor.constraint(equalToConstant: 10),
            
            
            forecastCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            forecastCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            forecastCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            forecastCollection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15),
            
            tempView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tempView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tempView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tempView.bottomAnchor.constraint(equalTo: forecastCollection.topAnchor),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
   
    // MARK:  Setup CollectionView
    func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return .init(section: section)
    }
}
// MARK:  UICollectionViewDataSource
extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.forecastWeather.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.indetifier, for: indexPath) as! ForecastCell
        cell.cellViewModel = viewModel.forecastWeather[indexPath.row]
        return cell
    }
}
// MARK:  OBJC func
extension MainView {
    @objc func didTapSearchBtn(_ sender: UIButton) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(SearchView(), animated: true)
    }
}
