//
//  TempView.swift
//  WeatherApp
//
//  Created by Александр Горелкин on 24.03.2024.
//

import UIKit

final class TempView: UIView {
    
    // MARK:  Top stack
    private lazy var dateLabel = DefaultLabel()
    private lazy var cityLabel = DefaultLabel(font: .systemFont(ofSize: 40, weight: .bold))
    private lazy var topStack = DefaultStackView(subview: [dateLabel, cityLabel])
    
    private lazy var weatherImage = DefaultImageView()
    
    // MARK:  Wind stack
    private lazy var windIcon = DefaultImageView()
    private lazy var windLabel = DefaultLabel()
    private lazy var windStack = DefaultStackView(subview: [windIcon, windLabel])
    
    // MARK:  Center stack
    private lazy var tempLabel = DefaultLabel(font: .systemFont(ofSize: 60, weight: .heavy))
    private lazy var descriptionLabel = DefaultLabel(font: .systemFont(ofSize: 20, weight: .regular))
    private lazy var minMaxLabel = DefaultLabel(font: .systemFont(ofSize: 10, weight: .thin))
    private lazy var centerStack = DefaultStackView(subview: [tempLabel, descriptionLabel, minMaxLabel])
    
    // MARK:  Humidity stack
    private lazy var humidityIcon = DefaultImageView()
    private lazy var humidityLabel = DefaultLabel()
    private lazy var humidityStack = DefaultStackView(subview: [humidityIcon, humidityLabel])
    
    
    var viewModel: TempViewModel? {
        didSet {
            dateLabel.text = viewModel?.time
            cityLabel.text = viewModel?.city
            windLabel.text = viewModel?.wind
            windIcon.image = UIImage(systemName: "wind")!
            tempLabel.text = viewModel?.temp
            descriptionLabel.text = viewModel?.tempDescription
            minMaxLabel.text = viewModel?.minMaxTemp
            humidityLabel.text = viewModel?.humidity
            humidityIcon.image = UIImage(systemName: "humidity")!
            Task {
                self.weatherImage.image = await viewModel?.getIcon()
            }
        }
    }
    init() {
        super.init(frame: .zero)
        addView(topStack)
        addView(weatherImage)
        addView(windStack)
        addView(centerStack)
        addView(humidityStack)
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: topAnchor),
            topStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            centerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            centerStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            windStack.topAnchor.constraint(equalTo: centerStack.topAnchor, constant: 10),
            windStack.leftAnchor.constraint(equalTo: leftAnchor),
            windStack.rightAnchor.constraint(equalTo: centerStack.leftAnchor),
            
            humidityStack.topAnchor.constraint(equalTo: centerStack.topAnchor, constant: 10),
            humidityStack.rightAnchor.constraint(equalTo: rightAnchor),
            humidityStack.leftAnchor.constraint(equalTo: centerStack.rightAnchor),
            
            
            weatherImage.topAnchor.constraint(equalTo: topStack.bottomAnchor),
            weatherImage.leftAnchor.constraint(equalTo: leftAnchor),
            weatherImage.rightAnchor.constraint(equalTo: rightAnchor),
            weatherImage.bottomAnchor.constraint(equalTo: centerStack.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
